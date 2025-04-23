import 'package:flutter/material.dart';

// Tela principal de tarefas
class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  // Lista de tarefas pendentes
  final List<String> _pendingTasks = [
    'Tarefa 1: Preparar apresentação',
    'Tarefa 2: Reunião com equipe',
    'Tarefa 3: Estudar Flutter',
    'Tarefa 4: Responder e-mails',
    'Tarefa 5: Atualizar projeto',
  ];

  // Lista de tarefas concluídas
  final List<String> _completedTasks = [
    'Tarefa A: Revisar código',
    'Tarefa B: Enviar relatório',
    'Tarefa C: Organizar documentos',
  ];

  // Controlador para o campo de texto
  final TextEditingController _taskController = TextEditingController();

  // Controlador das abas
  late TabController _tabController;

  // Filtro selecionado
  String _filterOption = 'Todas';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  // Adiciona nova tarefa à lista de pendentes
  void _addTask() {
    if (_taskController.text.trim().isNotEmpty) {
      setState(() => _pendingTasks.add(_taskController.text.trim()));
      _taskController.clear();
    }
  }

  // Remove tarefa concluída da lista
  void _removeCompletedTask(int index) {
    setState(() => _completedTasks.removeAt(index));
  }

  // Mostra diálogo para adicionar nova tarefa
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Adicionar Nova Tarefa'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(hintText: 'Digite a tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancelar', style: TextStyle(color: Colors.blueAccent)),
          ),
          TextButton(
            onPressed: () {
              _addTask();
              Navigator.of(ctx).pop();
            },
            child: Text('Adicionar', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  // Menu suspenso com opções de filtro
  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
      value: _filterOption,
      items: ['Todas', 'Somente Importantes', 'Somente Curtas']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _filterOption = value;
          });
        }
      },
    );
  }

  // Aplica filtro à lista de tarefas
  List<String> _applyFilter(List<String> tasks) {
    switch (_filterOption) {
      case 'Somente Importantes':
        return tasks.where((t) =>
            t.toLowerCase().contains('reunião') || t.toLowerCase().contains('apresentação')).toList();
      case 'Somente Curtas':
        return tasks.where((t) => t.length <= 25).toList();
      default:
        return tasks;
    }
  }

  // Widget que monta a lista de tarefas
  Widget _buildTaskList(List<String> tasks, {bool isCompleted = false}) {
    final filteredTasks = _applyFilter(tasks);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Cabeçalho com total de tarefas + filtro
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ${filteredTasks.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildFilterDropdown(),
            ],
          ),
          const SizedBox(height: 10),
          // Lista de tarefas renderizada dinamicamente
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green[50] : Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      filteredTasks[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isCompleted ? Colors.green[700] : Colors.blueGrey[700],
                      ),
                    ),
                    // Ícone do status da tarefa
                    leading: Icon(
                      isCompleted ? Icons.check_circle : Icons.access_time,
                      color: isCompleted ? Colors.green : Colors.orangeAccent,
                    ),
                    // Ação de concluir ou remover tarefa
                    trailing: isCompleted
                        ? IconButton(
                            icon: Icon(Icons.delete_forever, color: Colors.red),
                            onPressed: () => _removeCompletedTask(index),
                          )
                        : IconButton(
                            icon: Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                _completedTasks.add(filteredTasks[index]);
                                _pendingTasks.remove(filteredTasks[index]);
                              });
                            },
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Estrutura principal da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.green[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                'Tarefas Futuristas',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Pendentes (${_pendingTasks.length})'),
              Tab(text: 'Concluídas (${_completedTasks.length})'),
            ],
            indicatorColor: Colors.deepOrangeAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[300],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTaskList(_pendingTasks),
          _buildTaskList(_completedTasks, isCompleted: true),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        elevation: 8,
      ),
    );
  }
}

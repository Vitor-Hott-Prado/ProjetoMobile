import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  // Lista de tarefas simulada
  final List<String> _pendingTasks = [
    'Tarefa 1: Preparar apresentação',
    'Tarefa 2: Reunião com equipe',
    'Tarefa 3: Estudar Flutter',
    'Tarefa 4: Responder e-mails',
    'Tarefa 5: Atualizar projeto',
  ];
  final List<String> _completedTasks = [
    'Tarefa A: Revisar código',
    'Tarefa B: Enviar relatório',
    'Tarefa C: Organizar documentos',
  ];

  final TextEditingController _taskController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Libera o controlador
    super.dispose();
  }

  // Função para adicionar tarefa
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _pendingTasks.add(_taskController.text);
      });
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // Altura maior para o AppBar
        child: AppBar(
          backgroundColor: Colors.blueAccent, // Gradiente no AppBar
          elevation: 0,
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
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [Tab(text: 'Pendentes'), Tab(text: 'Concluídas')],
            indicatorColor: Colors.deepOrangeAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[300],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Aba Pendentes
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: _pendingTasks.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      _pendingTasks[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[700],
                      ),
                    ),
                    leading: Icon(
                      Icons.access_time,
                      color: Colors.orangeAccent,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          _completedTasks.add(_pendingTasks[index]);
                          _pendingTasks.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Aba Concluídas
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: _completedTasks.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      _completedTasks[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                    leading: Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Adicionar Nova Tarefa'),
                content: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(hintText: 'Digite a tarefa'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addTask();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Adicionar',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        elevation: 8,
      ),
    );
  }
}

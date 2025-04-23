import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  // Lista de tarefas pendentes e concluídas
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

  final TextEditingController _taskController = TextEditingController(); // Controlador para o TextField

  late TabController _tabController; // Controlador do TabBar

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Inicializa o controlador do TabBar com 2 abas
  }

  @override
  void dispose() {
    _tabController.dispose(); // Libera o controlador do TabBar quando a tela for descartada
    super.dispose();
  }

  // Função para adicionar uma nova tarefa à lista de pendentes
  void _addTask() {
    if (_taskController.text.isNotEmpty) { // Verifica se o campo de tarefa não está vazio
      setState(() {
        _pendingTasks.add(_taskController.text); // Adiciona a tarefa à lista de pendentes
      });
      _taskController.clear(); // Limpa o campo de texto após adicionar a tarefa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com maior altura e gradiente
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // Altura maior para o AppBar
        child: AppBar(
          backgroundColor: Colors.blueAccent, // Cor de fundo do AppBar
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.green[600]!], // Gradiente de cores no AppBar
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
            controller: _tabController, // Controlador do TabBar
            tabs: [Tab(text: 'Pendentes'), Tab(text: 'Concluídas')], // Abas para "Pendentes" e "Concluídas"
            indicatorColor: Colors.deepOrangeAccent, // Cor do indicador da aba
            labelColor: Colors.white, // Cor do texto da aba selecionada
            unselectedLabelColor: Colors.grey[300], // Cor do texto das abas não selecionadas
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Controlador do TabBarView
        children: [
          // Aba Pendentes - Exibe a lista de tarefas pendentes
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: _pendingTasks.length, // Quantidade de tarefas pendentes
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300), // Duração da animação
                  curve: Curves.easeInOut, // Tipo de animação
                  margin: EdgeInsets.symmetric(vertical: 8), // Margem para separar as tarefas
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50], // Cor de fundo da tarefa pendente
                    borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Cor da sombra
                        blurRadius: 10, // Desfoque da sombra
                        offset: Offset(0, 5), // Deslocamento da sombra
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      _pendingTasks[index], // Nome da tarefa pendente
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[700],
                      ),
                    ),
                    leading: Icon(
                      Icons.access_time, // Ícone de relógio para tarefas pendentes
                      color: Colors.orangeAccent,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green), // Ícone de "check" para marcar como concluída
                      onPressed: () {
                        setState(() {
                          // Move a tarefa para a lista de concluídas
                          _completedTasks.add(_pendingTasks[index]);
                          _pendingTasks.removeAt(index); // Remove da lista de pendentes
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Aba Concluídas - Exibe a lista de tarefas concluídas
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: _completedTasks.length, // Quantidade de tarefas concluídas
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300), // Duração da animação
                  curve: Curves.easeInOut, // Tipo de animação
                  margin: EdgeInsets.symmetric(vertical: 8), // Margem para separar as tarefas
                  decoration: BoxDecoration(
                    color: Colors.green[50], // Cor de fundo para tarefas concluídas
                    borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Cor da sombra
                        blurRadius: 10, // Desfoque da sombra
                        offset: Offset(0, 5), // Deslocamento da sombra
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      _completedTasks[index], // Nome da tarefa concluída
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                    leading: Icon(Icons.check_circle, color: Colors.green), // Ícone de "check" para tarefas concluídas
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // FloatingActionButton para adicionar novas tarefas
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Exibe um Dialog para adicionar uma nova tarefa
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Adicionar Nova Tarefa'),
                content: TextField(
                  controller: _taskController, // Controlador do campo de texto
                  decoration: InputDecoration(hintText: 'Digite a tarefa'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o Dialog
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addTask(); // Adiciona a tarefa
                      Navigator.of(context).pop(); // Fecha o Dialog
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
        child: Icon(Icons.add), // Ícone de adicionar tarefa
        backgroundColor: Colors.blueAccent,
        elevation: 8,
      ),
    );
  }
}

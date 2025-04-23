import 'package:flutter/material.dart'; // Pacote principal do Flutter para UI
import 'package:fl_chart/fl_chart.dart'; // Pacote para gráficos (utilizado para o gráfico de pizza)
import 'package:google_fonts/google_fonts.dart'; // Permite usar fontes do Google Fonts

// Widget de tela com estado (permite atualização da interface)
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Listas para armazenar tarefas pendentes e concluídas
  List<String> _pendingTasks = ['Tarefa 1', 'Tarefa 2'];
  List<String> _completedTasks = ['Tarefa A'];

  // Função para adicionar nova tarefa
  void _addTask() {
    TextEditingController _taskController = TextEditingController(); // Controlador para input de texto

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Borda arredondada
          title: Text(
            'Adicionar Nova Tarefa',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: 'Nome da Tarefa',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            // Botão de adicionar tarefa
            TextButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  setState(() {
                    _pendingTasks.add(_taskController.text); // Adiciona tarefa à lista de pendentes
                  });
                  Navigator.of(context).pop(); // Fecha o diálogo
                }
              },
              child: Text('Adicionar'),
            ),
            // Botão de cancelar
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = [Color(0xFF6A11CB), Color(0xFF2575FC)]; // Gradiente usado nos títulos e AppBar

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          '📊 Dashboard de Tarefas',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: gradientColors[0],
        elevation: 6,
        actions: [
          // Botão "+" para adicionar nova tarefa
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: _addTask,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da seção
            Text(
              'Resumo das Tarefas',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: gradientColors[0],
              ),
            ),
            SizedBox(height: 20),
            // Grid com cards de resumo
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Desativa scroll dentro do Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 colunas
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
              ),
              itemCount: 4, // Número de cards
              itemBuilder: (context, index) {
                IconData icon;
                String title;
                String value;
                Color bgColor;

                // Define os dados dos cards com base no índice
                switch (index) {
                  case 0:
                    icon = Icons.pending_actions_rounded;
                    title = 'Pendentes';
                    value = _pendingTasks.length.toString();
                    bgColor = Colors.orangeAccent;
                    break;
                  case 1:
                    icon = Icons.check_circle_outline;
                    title = 'Concluídas';
                    value = _completedTasks.length.toString();
                    bgColor = Colors.green;
                    break;
                  case 2:
                    icon = Icons.loop;
                    title = 'Em Andamento';
                    value = '0'; // Placeholder
                    bgColor = Colors.amber;
                    break;
                  default:
                    icon = Icons.task;
                    title = 'Total';
                    value = (_pendingTasks.length + _completedTasks.length).toString();
                    bgColor = Colors.deepPurple;
                }

                // Layout de cada card
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [bgColor.withOpacity(0.9), bgColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: bgColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: Colors.white, size: 34),
                        SizedBox(height: 8),
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          value,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32),
            // Título da seção de progresso
            Text(
              'Progresso das Tarefas',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: gradientColors[0],
              ),
            ),
            SizedBox(height: 24),
            // Gráfico de pizza mostrando pendentes vs concluídas
            AspectRatio(
              aspectRatio: 1.4,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 6,
                  centerSpaceRadius: 45,
                  sections: [
                    // Seção de tarefas pendentes
                    PieChartSectionData(
                      value: _pendingTasks.length.toDouble(),
                      color: Colors.orangeAccent,
                      title: 'Pendentes',
                      radius: 60,
                      titleStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Seção de tarefas concluídas
                    PieChartSectionData(
                      value: _completedTasks.length.toDouble(),
                      color: Colors.green,
                      title: 'Concluídas',
                      radius: 60,
                      titleStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 28),
            // Resumo final com quantidade de tarefas
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[100]!],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                '📌 Pendentes: ${_pendingTasks.length}   |   ✅ Concluídas: ${_completedTasks.length}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: gradientColors[0],
                ),
              ),
            ),
          ],
        ),  
      ),
    );
  }
}

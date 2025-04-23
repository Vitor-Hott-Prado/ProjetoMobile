// Matheus

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Importa as telas auxiliares
import 'dashboard_screen.dart';
import 'settings_screen.dart';
import 'task_screen.dart';

// Componente principal que gerencia a tela inicial com navegação inferior
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Estado da HomeScreen com animação e controle de abas
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0; // Índice da aba selecionada
  late AnimationController _appBarController; // Controlador para animar o título do AppBar

  // Altera a aba selecionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Retorna a tela conforme a aba selecionada
  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return TaskScreen(); // Tela de tarefas
      case 1:
        return SettingsScreen(); // Tela de configurações
      default:
        return TaskScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    // Inicializa a animação do título do AppBar
    _appBarController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _appBarController.dispose(); // Encerra o controlador ao destruir o widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Gradientes usados no AppBar
    final List<List<Color>> gradientColors = [
      [Color(0xFF6A11CB), Color(0xFF2575FC)], // Para a aba de tarefas
      [Color(0xFFFF4E50), Color(0xFFF9D423)], // Para a aba de configurações
    ];

    return Scaffold(
      extendBody: true, // Estende o corpo abaixo da barra de navegação
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        // Anima o fundo do AppBar com gradiente
        flexibleSpace: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _selectedIndex == 0 ? gradientColors[0] : gradientColors[1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Animação do título
        title: FadeTransition(
          opacity: _appBarController,
          child: Text(
            _selectedIndex == 0 ? '✨ Minhas Tarefas' : '⚙️ Configurações',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        actions: [
          // Botão de notificações
          IconButton(
            icon: Icon(Icons.notifications_active_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('📣 Você tem novas notificações!'),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
              );
            },
          ),
        ],
      ),

      // Menu lateral (Drawer)
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Cabeçalho com usuário
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.transparent),
                  accountName: Text(
                    "Usuário Topzera",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text("email@exemplo.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/avatar.png"),
                  ),
                ),
                // Botão para abrir o Dashboard
                ListTile(
                  leading: Icon(Icons.dashboard_customize, color: Colors.white),
                  title: Text('Dashboard', style: GoogleFonts.poppins(color: Colors.white)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  ),
                ),
                // Botão para abrir Configurações
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text('Configurações', style: GoogleFonts.poppins(color: Colors.white)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  ),
                ),
                Spacer(),
                // Botão de sair do menu
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.white),
                  title: Text('Sair', style: GoogleFonts.poppins(color: Colors.white)),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),

      // Corpo da tela com animação de troca
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _getSelectedScreen(),
      ),

      // Barra de navegação inferior
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Tarefas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Configurações',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

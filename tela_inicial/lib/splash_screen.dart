import 'package:flutter/material.dart';
import 'login_screen.dart';

// Tela de Splash que é exibida inicialmente
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula a tela de splash por 3 segundos antes de navegar para a tela de Login
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navega para a tela de Login
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Corpo da tela com uma mensagem centralizada
      body: Center(
        child: Text(
          'Bem-vindo ao Meu App!', // Mensagem de boas-vindas na tela de Splash
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

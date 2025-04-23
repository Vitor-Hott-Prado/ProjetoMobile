import 'package:flutter/material.dart';
// Importa a tela de login como ponto inicial
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tema claro do app
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent,
        textTheme: ButtonTextTheme.primary,
      ),
    );

    // Tema escuro do app
    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
    );

    // App principal
    return MaterialApp(
      title: 'Meu App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: LoginScreen(), // Agora inicia com a tela de login
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
    );
  }
}

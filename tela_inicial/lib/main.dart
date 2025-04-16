import 'package:flutter/material.dart';
import 'home_screen.dart'; // Certifique-se de importar sua tela principal corretamente

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tema Claro
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent,
        textTheme: ButtonTextTheme.primary,
      ),
    );

    // Tema Escuro
    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
    );

    return MaterialApp(
      title: 'Meu App',
      theme: lightTheme, // Definindo o tema claro por padrão
      darkTheme: darkTheme, // Definindo o tema escuro
      themeMode:
          ThemeMode
              .system, // Mudança automática com base na preferência do sistema
      home: HomeScreen(),
    );
  }
}

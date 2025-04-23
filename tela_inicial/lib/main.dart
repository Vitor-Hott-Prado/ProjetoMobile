import 'package:flutter/material.dart';
// Importa o arquivo da tela principal (home), que será exibida ao abrir o app
import 'home_screen.dart'; // Certifique-se de importar sua tela principal corretamente

void main() {
  // Função principal que inicia o aplicativo Flutter
  runApp(MyApp());
}

// Widget principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Definindo o tema claro do aplicativo
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light, // Define o brilho como claro
      primarySwatch: Colors.blue, // Cor primária padrão
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent), // Cor da AppBar
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent, // Cor dos botões
        textTheme: ButtonTextTheme.primary, // Cor do texto nos botões
      ),
    );

    // Definindo o tema escuro do aplicativo
    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark, // Define o brilho como escuro
      primarySwatch: Colors.blue, // Mantém a mesma cor primária
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey), // Cor da AppBar no modo escuro
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey, // Cor dos botões no modo escuro
        textTheme: ButtonTextTheme.primary, // Cor do texto nos botões
      ),
    );

    // Retorna o MaterialApp, que é o container principal do app
    return MaterialApp(
      title: 'Meu App', // Título do aplicativo
      theme: lightTheme, // Define o tema claro como padrão
      darkTheme: darkTheme, // Define o tema escuro
      themeMode: ThemeMode.system, // Alterna entre claro e escuro conforme o sistema
      home: HomeScreen(), // Define a tela inicial como HomeScreen
    );
  }
}

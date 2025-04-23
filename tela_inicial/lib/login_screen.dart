import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  // Controladores de animação para os campos de email, senha e botão de login
  late AnimationController _emailController;
  late AnimationController _senhaController;
  late AnimationController _buttonController;

  final _formKey = GlobalKey<FormState>(); // Usado para validação do formulário
  final TextEditingController _emailControllerText = TextEditingController();
  final TextEditingController _senhaControllerText = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores de animação com diferentes durações
    _emailController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();
    _senhaController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();
    _buttonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..forward();
  }

  // Função de login que valida o formulário e navega para a tela inicial se válido
  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Navega para a HomeScreen
      );
    }
  }

  @override
  void dispose() {
    // Libera os controladores de animação quando a tela for descartada
    _emailController.dispose();
    _senhaController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Gradiente de fundo na tela de login
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Título da tela de login
                  Text(
                    'Gerenciador de Tarefas',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Campo de email com animação de fade-in
                  FadeTransition(
                    opacity: _emailController,
                    child: _buildInputField(
                      label: 'Email',
                      icon: Icons.email,
                      obscure: false,
                      controller: _emailControllerText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo é obrigatório'; // Validação de email vazio
                        }
                        if (!value.contains('@')) {
                          return 'Digite um email válido'; // Validação de formato de email
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  // Campo de senha com animação de fade-in
                  FadeTransition(
                    opacity: _senhaController,
                    child: _buildInputField(
                      label: 'Senha',
                      icon: Icons.lock,
                      obscure: true,
                      controller: _senhaControllerText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo é obrigatório'; // Validação de senha vazia
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40),

                  // Botão de login com animação de escala
                  AnimatedBuilder(
                    animation: _buttonController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1 + (_buttonController.value * 0.05), // Efeito de aumentar o botão ao carregar
                        child: ElevatedButton(
                          onPressed: () => _login(context), // Chama a função de login
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 50,
                            ),
                            child: Text(
                              'Entrar',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF4A00E0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 10, // Adiciona sombra ao botão
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Link para "Esqueceu a senha?"
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Ícones para login com redes sociais (Facebook e Google)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.white),
                        onPressed: () {}, // Ação de login via Facebook
                      ),
                      IconButton(
                        icon: Icon(Icons.g_mobiledata, color: Colors.white),
                        onPressed: () {}, // Ação de login via Google
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Link para "Criar uma conta"
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Criar uma conta',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Função que constrói os campos de entrada (email/senha) com animação e validação
  Widget _buildInputField({
    required String label,
    required IconData icon,
    required bool obscure,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        // Estilo da caixa de texto com sombra
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
        borderRadius: BorderRadius.circular(16), // Bordas arredondadas
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure, // Se o campo for para senha (ocultar texto)
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4A00E0)), // Ícone dentro do campo de texto
          filled: true,
          fillColor: Colors.white.withOpacity(0.95), // Cor de fundo do campo de texto
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        validator: validator, // Valida o valor do campo
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

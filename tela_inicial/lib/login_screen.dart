import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _emailController;
  late AnimationController _senhaController;
  late AnimationController _buttonController;

  final _formKey = GlobalKey<FormState>(); // Usado para validação do formulário
  final TextEditingController _emailControllerText = TextEditingController();
  final TextEditingController _senhaControllerText = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
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

                  FadeTransition(
                    opacity: _emailController,
                    child: _buildInputField(
                      label: 'Email',
                      icon: Icons.email,
                      obscure: false,
                      controller: _emailControllerText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo é obrigatório';
                        }
                        if (!value.contains('@')) {
                          return 'Digite um email válido';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  FadeTransition(
                    opacity: _senhaController,
                    child: _buildInputField(
                      label: 'Senha',
                      icon: Icons.lock,
                      obscure: true,
                      controller: _senhaControllerText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo é obrigatório';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40),

                  AnimatedBuilder(
                    animation: _buttonController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1 + (_buttonController.value * 0.05),
                        child: ElevatedButton(
                          onPressed: () => _login(context),
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
                            elevation: 10,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.g_mobiledata, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

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

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required bool obscure,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4A00E0)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.95),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        validator: validator,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

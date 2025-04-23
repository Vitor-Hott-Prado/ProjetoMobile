// Matheus
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController _emailAnim, _senhaAnim, _btnAnim;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailAnim = AnimationController(vsync: this, duration: Duration(milliseconds: 800))..forward();
    _senhaAnim = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))..forward();
    _btnAnim   = AnimationController(vsync: this, duration: Duration(milliseconds: 1200))..forward();
  }

  @override
  void dispose() {
    _emailAnim.dispose();
    _senhaAnim.dispose();
    _btnAnim.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  // Constrói um campo de texto estilizado
  Widget _buildField(String label, IconData icon, bool obscure, TextEditingController controller, String? Function(String?) validator) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4A00E0)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.95),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gerenciador de Tarefas', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 40),

                  // Campos com animação
                  FadeTransition(
                    opacity: _emailAnim,
                    child: _buildField(
                      'Email', Icons.email, false, _emailCtrl,
                      (v) => v == null || v.isEmpty ? 'Campo obrigatório' : !v.contains('@') ? 'Email inválido' : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _senhaAnim,
                    child: _buildField(
                      'Senha', Icons.lock, true, _senhaCtrl,
                      (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Botão animado
                  AnimatedBuilder(
                    animation: _btnAnim,
                    builder: (_, child) => Transform.scale(
                      scale: 1 + (_btnAnim.value * 0.05),
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF4A00E0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                          child: Text('Entrar', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {}, child: Text('Esqueceu a senha?', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  SizedBox(height: 20),

                  // Ícones sociais (placeholders)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.facebook, color: Colors.white), onPressed: () {}),
                      IconButton(icon: Icon(Icons.g_mobiledata, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {}, child: Text('Criar uma conta', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

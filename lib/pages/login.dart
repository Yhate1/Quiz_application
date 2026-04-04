import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();

  bool _obscurePassword = true;
  bool _showError = false;

  final String _validName = 'ali';
  final String _validPass = '123';

  void _loginCheck() {
    if (nameCont.text == _validName && passCont.text == _validPass) {
      HapticFeedback.mediumImpact();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      HapticFeedback.lightImpact();
      setState(() => _showError = true);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showError = false);
      });
    }
  }

  @override
  void dispose() {
    nameCont.dispose();
    passCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: isSmallScreen ? 40 : 80),
              const Text(
                'QuizMaster',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
              ),
              SizedBox(height: isSmallScreen ? 40 : 64),

              if (_showError)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFef4444).withOpacity(0.15),
                    border: Border.all(color: const Color(0xFFef4444), width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFef4444), size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Invalid username or password',
                          style: const TextStyle(color: Color(0xFFef4444), fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              _buildInputField(
                controller: nameCont,
                label: 'Username',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              _buildPasswordField(),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loginCheck,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3b82f6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 32 : 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF141830), Color(0xFF141830)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF141830), Color(0xFF141830)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: passCont,
        obscureText: _obscurePassword,
        style: const TextStyle(color: Colors.white),
        onSubmitted: (_) => _loginCheck(),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
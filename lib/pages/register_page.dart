import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:pertemuan_4/models/user_model.dart';
import 'package:pertemuan_4/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _levelController = TextEditingController();
  final _rankController = TextEditingController();
  final _roleController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        name: _nameController.text,
        password: _passwordController.text,
        level: int.tryParse(_levelController.text) ?? 1,
        rank: _rankController.text,
        role: _roleController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: user)),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _levelController.dispose();
    _rankController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Decorative Orbs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.shield_moon_rounded, size: 64, color: Colors.blueAccent),
                            const SizedBox(height: 16),
                            const Text(
                              "Join The Guild",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 32),
                            
                            _buildTextField(_nameController, "Name", Icons.person_outline),
                            const SizedBox(height: 16),
                            _buildTextField(_passwordController, "Password", Icons.lock_outline, isPassword: true),
                            const SizedBox(height: 16),
                            _buildTextField(_levelController, "Level", Icons.military_tech_outlined, isNumber: true),
                            const SizedBox(height: 16),
                            _buildTextField(_rankController, "Rank (S/A/B/C)", Icons.star_border),
                            const SizedBox(height: 16),
                            _buildTextField(_roleController, "Role Class", Icons.psychology_outlined),
                            const SizedBox(height: 40),

                            // Submit Button
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "ENTER ADVENTURE",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.6)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purpleAccent),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return '$label is required';
        if (label == 'Password' && value.length < 8) return 'Min 8 characters';
        if (label == 'Level' && int.tryParse(value) == null) return 'Numbers only';
        if (label == 'Rank (S/A/B/C)' && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) return 'Letters and spaces only';
        return null;
      },
    );
  }
}


// lib/new_password.dart
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _pwCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _pwObscure = true;
  bool _confirmObscure = true;

  @override
  void dispose() {
    _pwCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Widget _gradientButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFB64D), Color(0xFFFF8800)],
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 6),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Update new password',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _updatePassword() {
    final pw = _pwCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (pw.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill both password fields')),
      );
      return;
    }
    if (pw.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }
    if (pw != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // TODO: Call your backend here to actually update the password.

    // On success -> go to success screen
    Navigator.pushNamed(context, '/success');
  }

  @override
  Widget build(BuildContext context) {
    const subtleGrey = Color(0xFFF5F5F7);

    InputDecoration _pwDecoration(String label) => InputDecoration(
          labelText: label,
          filled: true,
          fillColor: subtleGrey,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  const Text(
                    'New password',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Set your new password.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),

                  const SizedBox(height: 28),

                  // Password
                  TextField(
                    controller: _pwCtrl,
                    obscureText: _pwObscure,
                    decoration: _pwDecoration('Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_pwObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _pwObscure = !_pwObscure),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Confirm password
                  TextField(
                    controller: _confirmCtrl,
                    obscureText: _confirmObscure,
                    decoration: _pwDecoration('Confirm password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_confirmObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _confirmObscure = !_confirmObscure),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  _gradientButton('Update new password', _updatePassword),

                  const Spacer(),

                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 18),
                      child: Text(
                        'Designed & Developed by Uvexzon',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Back circle button (bottom-left)
            Positioned(
              left: 16,
              bottom: 26,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFF3F3F5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

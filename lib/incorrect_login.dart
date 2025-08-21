import 'package:flutter/material.dart';

class IncorrectLoginScreen extends StatelessWidget {
  const IncorrectLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const subtleGrey = Color(0xFFF5F5F7);

    InputDecoration errorField({
      required String label,
      required String hint,
      required String inlineError,
    }) {
      return InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: subtleGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.4),
        ),
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 18),
            const SizedBox(width: 6),
            Text(inlineError,
                style: const TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
      );
    }

    Widget gradientButton(String text, VoidCallback onTap) {
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
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Login to your account.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 28),

              // Email with inline error
              TextField(
                controller: TextEditingController(text: 'Shav@gmail.com'),
                keyboardType: TextInputType.emailAddress,
                decoration: errorField(
                  label: 'Email',
                  hint: 'shav@gmail.com',
                  inlineError: 'Email is incorrect',
                ),
              ),

              const SizedBox(height: 16),

              // Password with inline error
              TextField(
                obscureText: true,
                decoration: errorField(
                  label: 'Password',
                  hint: '........',
                  inlineError: 'Password is incorrect',
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (_) {}),
                      const Text('Remember me.'),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forgot'),
                    child: const Text('Forgot password?'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Login again (keeps you here or pop to clean login)
              gradientButton('Login', () {
                // If you prefer to retry on the clean login screen:
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              }),

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
      ),
    );
  }
}

// lib/forgot_password.dart
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const subtleGrey = Color(0xFFF5F5F7);
    final emailCtrl = TextEditingController();

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
              BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 6),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    void goToVerify() {
      final email = emailCtrl.text.trim();
      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your email')),
        );
        return;
      }
      // TODO: call your backend to send OTP to [email]
      Navigator.pushNamed(context, '/verify');
    }

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
                    'Forgot Password',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Enter your email to reset the password.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),

                  const SizedBox(height: 28),

                  const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),

                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'shav@gmail.com',
                      filled: true,
                      fillColor: subtleGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  gradientButton('Next', goToVerify),

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

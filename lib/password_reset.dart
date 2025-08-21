// lib/password_reset.dart
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

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
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _goToNewPassword(BuildContext context) {
    // Navigate to the New Password screen
    Navigator.pushNamed(context, '/new-password');
  }

  @override
  Widget build(BuildContext context) {
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
                    'Password Reset',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your password has been successfully reset. '
                    'Click Continue to set new password.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),

                  const Spacer(),

                  _gradientButton('Continue', () => _goToNewPassword(context)),

                  const SizedBox(height: 24),

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

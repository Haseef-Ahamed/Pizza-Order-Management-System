// lib/successful_screen.dart
import 'package:flutter/material.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  void _goToSignupOne(BuildContext context) {
    // Go to signup step 1 and clear stack so user can’t go back into reset flow
    Navigator.pushNamedAndRemoveUntil(context, '/signup-one', (route) => false);
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
          'Continue',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Green success badge
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF11A44A), width: 4),
                ),
                child: const Center(
                  child: Icon(Icons.check, size: 64, color: Color(0xFF11A44A)),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Successful',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Congratulations, the new password has been set.\nClick Continue to sign up.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              _gradientButton('Continue', () => _goToSignupOne(context)),
              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Text(
                  'Designed & Developed by Uvexzon',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// lib/signup_success.dart
import 'package:flutter/material.dart';

class SignupSuccessScreen extends StatelessWidget {
  final String? userName;
  const SignupSuccessScreen({super.key, this.userName});

  void _goToDashboard(BuildContext context) {
    // Uses the named route defined in main.dart
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Gradient circle with check icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                        ),
                      ),
                      child: const Icon(Icons.check_rounded, size: 70, color: Colors.white),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Sign Up Successful',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      userName == null
                          ? 'Your account has been created.\nYou’re all set!'
                          : 'Welcome, $userName!\nYour account has been created.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        // FIX: withOpacity -> withValues
                        color: Colors.black.withValues(alpha: 0.60),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Continue button (orange gradient)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => _goToDashboard(context),
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.black26,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer credit (bottom-center)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Center(
                child: Text(
                  'Designed & Developed by Uvexzon',
                  style: theme.textTheme.bodySmall?.copyWith(
                    // FIX: withOpacity -> withValues
                    color: Colors.black.withValues(alpha: 0.60),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

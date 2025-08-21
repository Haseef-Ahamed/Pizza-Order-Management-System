// lib/signup_one.dart
import 'package:flutter/material.dart';

class SignupOneScreen extends StatefulWidget {
  const SignupOneScreen({super.key});

  @override
  State<SignupOneScreen> createState() => _SignupOneScreenState();
}

class _SignupOneScreenState extends State<SignupOneScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstCtrl = TextEditingController();
  final _lastCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _goNext() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pushNamed(
      context,
      '/signup-two',
      arguments: {
        'firstName': _firstCtrl.text.trim(),
        'lastName' : _lastCtrl.text.trim(),
        'email'    : _emailCtrl.text.trim(),
        'phone'    : _phoneCtrl.text.trim(),
      },
    );
  }

  InputDecoration _fieldDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      );

  Widget _gradientButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
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

  String? _notEmpty(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom; // keyboard

    return Scaffold(
      // this is true by default, but keeping it explicit
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Optional decorative pizza art
            Positioned(
              top: -40,
              right: -40,
              width: 230,
              height: 230,
              child: Image.asset(
                'assets/images/pizza.png',
                fit: BoxFit.cover,
              ),
            ),

            // >>> Make the whole page scrollable
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset + 24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),

                    const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Sign up to create an account.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 14),

                    // Step indicator (1 active, 1 inactive)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF9E3D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    const Text('First name*',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: _fieldDecoration('Shavon'),
                      validator: (v) => _notEmpty(v, 'Please enter first name'),
                    ),
                    const SizedBox(height: 16),

                    const Text('Last name*',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: _fieldDecoration('Fernando'),
                      validator: (v) => _notEmpty(v, 'Please enter last name'),
                    ),
                    const SizedBox(height: 16),

                    const Text('Email*',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: _fieldDecoration('shav@gmail.com'),
                      validator: (v) {
                        final base = _notEmpty(v, 'Please enter email');
                        if (base != null) return base;
                        final email = v!.trim();
                        final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email);
                        return ok ? null : 'Enter a valid email';
                      },
                    ),
                    const SizedBox(height: 16),

                    const Text('Phone no*',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: _fieldDecoration('0771234567'),
                      validator: (v) => _notEmpty(v, 'Please enter phone number'),
                    ),

                    const SizedBox(height: 26),

                    _gradientButton('Next', _goNext),

                    const SizedBox(height: 12),

                    // Footer
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
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
          ],
        ),
      ),
    );
  }
}

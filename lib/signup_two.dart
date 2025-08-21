// lib/signup_two.dart
import 'package:flutter/material.dart';

class SignupTwoScreen extends StatefulWidget {
  const SignupTwoScreen({super.key});

  @override
  State<SignupTwoScreen> createState() => _SignupTwoScreenState();
}

class _SignupTwoScreenState extends State<SignupTwoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Data from step 1 (optional, passed via Navigator arguments)
  Map<String, dynamic>? step1;

  // Fields on this screen
  String? _selectedRole;
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl  = TextEditingController();

  bool _obscurePw = true;
  bool _obscureConfirm = true;

  final List<String> _roles = const ['Owner', 'Manager', 'Staff'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read step1 arguments once (if any)
    step1 ??= (ModalRoute.of(context)?.settings.arguments as Map?)?.map(
      (k, v) => MapEntry(k.toString(), v),
    );
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _goToVerifyOtp() {
    if (!_formKey.currentState!.validate()) return;

    // Go directly to the signup verify OTP screen
    Navigator.pushNamed(
      context,
      '/signup-verify',
      arguments: {
        ...?step1,
        'role': _selectedRole,
        'password': _passwordCtrl.text.trim(),
      },
    );
  }

  InputDecoration _filledDecoration(String hint) => InputDecoration(
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
          'Sign up',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom; // ✅ keyboard height

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Optional pizza art
            Positioned(
              top: -40,
              right: -40,
              width: 220,
              height: 220,
              child: Image.asset(
                'assets/images/pizza.png',
                fit: BoxFit.cover,
              ),
            ),

            // Scrollable content with keyboard padding
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset + 24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),

                    const Text('Sign up',
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const Text(
                      'Sign up to create an account.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 14),

                    // Step indicator (both bars orange — finishing step)
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
                              color: const Color(0xFFFF9E3D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    const Text('Select Job role*',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      items: _roles
                          .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedRole = v),
                      decoration: _filledDecoration('Select'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      validator: (v) => v == null ? 'Please select a role' : null,
                    ),

                    const SizedBox(height: 16),

                    const Text('Password',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: _obscurePw,
                      decoration: _filledDecoration('••••••••').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePw ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscurePw = !_obscurePw),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter a password';
                        if (v.length < 6) return 'Must be at least 6 characters';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text('Confirm password',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: _obscureConfirm,
                      decoration: _filledDecoration('••••••••').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please confirm your password';
                        if (v != _passwordCtrl.text) return 'Passwords do not match';
                        return null;
                      },
                    ),

                    const SizedBox(height: 26),

                    _gradientButton('Sign up', _goToVerifyOtp),

                    const SizedBox(height: 12),

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

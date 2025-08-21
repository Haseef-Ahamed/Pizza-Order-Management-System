// lib/signup_verify_otp.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupVerifyOtpScreen extends StatefulWidget {
  const SignupVerifyOtpScreen({super.key});

  @override
  State<SignupVerifyOtpScreen> createState() => _SignupVerifyOtpScreenState();
}

class _SignupVerifyOtpScreenState extends State<SignupVerifyOtpScreen> {
  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  final _c4 = TextEditingController();

  final _f1 = FocusNode();
  final _f2 = FocusNode();
  final _f3 = FocusNode();
  final _f4 = FocusNode();

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    _c4.dispose();
    _f1.dispose();
    _f2.dispose();
    _f3.dispose();
    _f4.dispose();
    super.dispose();
  }

  String get _code => _c1.text + _c2.text + _c3.text + _c4.text;

  void _onChanged(String v, FocusNode current, FocusNode? next) {
    if (v.length == 1 && next != null) {
      next.requestFocus();
    } else if (v.isEmpty) {
      current.previousFocus();
    }
  }

  Widget _otpBox({
    required TextEditingController controller,
    required FocusNode node,
    FocusNode? next,
  }) {
    return SizedBox(
      width: 62,
      height: 62,
      child: TextField(
        controller: controller,
        focusNode: node,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.number,
        // IMPORTANT: don't mark this list const
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF5F5F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (v) => _onChanged(v, node, next),
      ),
    );
  }

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
          'Verify',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _verify() {
    if (_code.length == 4) {
      // TODO: verify OTP with your backend first if needed
      Navigator.pushNamed(context, '/signup-success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit code')),
      );
    }
  }

  void _resend() {
    // TODO: trigger resend via backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent (demo)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Optional pizza art (top-right). Remove if you don't have this asset.
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 140),

                  const Text(
                    'Verify OTP',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "We've sent one time verification code to shav@gmail.com.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _otpBox(controller: _c1, node: _f1, next: _f2),
                      _otpBox(controller: _c2, node: _f2, next: _f3),
                      _otpBox(controller: _c3, node: _f3, next: _f4),
                      _otpBox(controller: _c4, node: _f4),
                    ],
                  ),

                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the code yet? "),
                      GestureDetector(
                        onTap: _resend,
                        child: const Text(
                          'Resend',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  _gradientButton('Verify', _verify),
                  const SizedBox(height: 22),

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
          ],
        ),
      ),
    );
  }
}

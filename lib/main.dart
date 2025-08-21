import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'incorrect_login.dart';
import 'forgot_password.dart';
import 'verify_otp.dart';
import 'password_reset.dart';
import 'new_password.dart';
import 'successful_screen.dart';
import 'signup_one.dart';
import 'signup_two.dart';
import 'signup_verify_otp.dart';
import 'signup_success.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PizzaApp());
}

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza House',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF5F5F7),
          border: OutlineInputBorder(),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/incorrect': (_) => const IncorrectLoginScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(), 
        '/verify': (_) => const VerifyOtpScreen(),  
        '/password-reset': (_) => const PasswordResetScreen(),
        '/new-password': (_) => const NewPasswordScreen(),
        '/success': (_) => const SuccessfulScreen(),
        '/signup-one': (_) => const SignupOneScreen(),
        '/signup-two': (_) => const SignupTwoScreen(),
        '/signup-verify': (_) => const SignupVerifyOtpScreen(),
        '/signup-success': (_) => const SignupSuccessScreen(),


      },
    );
  }
}

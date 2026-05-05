import 'package:flutter/material.dart';
import 'package:turf_application/constants.dart';
import 'package:turf_application/screens/phone_otp_screen.dart';

import 'forget_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Title
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: kPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'ACCESS YOUR HIGH-PERFORMANCE\nENGINE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 52),

              // Email
              const Align(
                alignment: Alignment.centerLeft,
                child: FieldLabel('EMAIL ADDRESS'),
              ),
              const SizedBox(height: 8),
              const AuthInputField(
                hint: 'alex@example.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password row with label + forgot link
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FieldLabel('PASSWORD'),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen()),
                    ),
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 12,
                        color: kPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AuthInputField(
                hint: '••••••••',
                obscure: _obscure,
                suffix: IconButton(
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded,
                          color: Colors.black, size: 20),
                    ],
                  ),
                ),
              ),


              const SizedBox(height: 28),

              // OR divider
              const OrDivider(),

              const SizedBox(height: 20),

              // Login with phone button
              AuthOutlineButton(
                label: 'LOGIN WITH PHONE',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PhoneOtpScreen()),
                ),
              ),

              const SizedBox(height: 40),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "if you don't have an account ? ",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Sign Up screen
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 13,
                        color: kPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
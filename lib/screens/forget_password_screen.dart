import 'package:flutter/material.dart';
import 'package:turf_application/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Back arrow
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: kPrimary, size: 24),
              ),

              const SizedBox(height: 32),

              // Heading
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(text: 'Forgot '),
                    TextSpan(
                      text: 'Password',
                      style: TextStyle(color: kPrimary),
                    ),
                    TextSpan(text: ' ?'),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Enter your email and we will send you a link to reset\nyour password.',
                style: TextStyle(fontSize: 13, color: Colors.black, height: 1.5),
              ),

              const SizedBox(height: 48),

              const FieldLabel('EMAIL ADDRESS'),
              const SizedBox(height: 10),

              // Email field with icon
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: kLight,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(Icons.mail_outline, color: kPrimary, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'alex@example.com',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Set Reset Link button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
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
                        'Set Reset Link',
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
            ],
          ),
        ),
      ),
    );
  }
}
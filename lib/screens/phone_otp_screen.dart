import 'package:flutter/material.dart';
import 'package:turf_application/constants.dart';

class PhoneOtpScreen extends StatefulWidget {
  const PhoneOtpScreen({super.key});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  bool _otpSent = false;
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _otpControllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: kPrimary, // 👈 same as GET OTP button
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: kWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Mobile Number label
                const FieldLabel('MOBILE NUMBER'),
                const SizedBox(height: 10),

                // Phone input with +91 prefix
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: kLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      const Text(
                        '+91',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // GET OTP button
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _otpSent = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'GET OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),

                // OTP section — appears after GET OTP is tapped
                if (_otpSent) ...[
                  const SizedBox(height: 28),
                  const FieldLabel('ENTER 6-DIGIT OTP'),
                  const SizedBox(height: 14),

                  // 6 OTP boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (i) {
                      return SizedBox(
                        width: 46,
                        height: 52,
                        child: TextField(
                          controller: _otpControllers[i],
                          focusNode: _focusNodes[i],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: kLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: kPrimary, width: 1.5),
                            ),
                          ),
                          onChanged: (v) {
                            if (v.isNotEmpty && i < 5) {
                              _focusNodes[i + 1].requestFocus();
                            } else if (v.isEmpty && i > 0) {
                              _focusNodes[i - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ],

                const SizedBox(height: 32),

                // OR divider
                const OrDivider(),

                const SizedBox(height: 24),

                // Continue with Google
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Google sign-in
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GoogleIcon(),
                        SizedBox(width: 10),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
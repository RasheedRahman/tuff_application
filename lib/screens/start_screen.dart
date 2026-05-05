import 'package:flutter/material.dart';
import 'package:turf_application/screens/login_screen.dart';
import 'package:turf_application/screens/physical_details_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔶 Background Image
          SizedBox.expand(
            child: Image.asset(

              "assets/images/start_page_image.png", // your image
              fit: BoxFit.contain,
            ),
          ),

          // 🔶 Dark Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),

          // 🔶 Bottom Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top text (optional)
                  // const SizedBox(height: 10),
                  // const Text(
                  //   "start",
                  //   style: TextStyle(color: Colors.white70),
                  // ),

                  const Spacer(),

                  // Title
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Train Smarter. Move Stronger.\n",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "Become Unstoppable.",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔶 Start Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhysicalDetailsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "START",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔶 Bottom Text
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        children: const [
                          Text(
                            "Already user?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Continue with your existing account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
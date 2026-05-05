import 'package:flutter/material.dart';
import 'package:turf_application/screens/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> data = [
    {
      "title": "Push Beyond Your Limits.",
      "desc":
      "Unlock your true potential with personalized workouts and expert guidance tailored just for you.",
      "image": "assets/images/gym1.png",
    },
    {
      "title": "Train Smart. Stay Consistent.",
      "desc":
      "Track progress, follow structured programs, and stay on top of your fitness journey every single day.",
      "image": "assets/images/gym2.png",
    },
    {
      "title": "Your Fitness Journey Starts Here.",
      "desc":
      "Build strength, improve endurance, and transform your lifestyle—one workout at a time.",
      "image": "assets/images/gym3.png",
    },
  ];

  void nextPage() {
    if (_currentPage < data.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // ✅ Navigate to StartScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const StartScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //SizedBox(height: 50,),
            // 🔶 Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 0,
                  end: (_currentPage + 1) / data.length,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 4,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    ),
                  );
                },
              ),
            ),

            // 🔶 Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: data.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          data[index]["image"]!,
                          height: 200,
                        ),
                        const SizedBox(height: 40),

                        Text(
                          data[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          data[index]["desc"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔶 Next Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _currentPage == data.length - 1
                        ? "GET STARTED"
                        : "NEXT",
                  ),
                  //child: Text("NEXT",
                  //),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
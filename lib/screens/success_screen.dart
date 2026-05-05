import 'package:flutter/material.dart';
import 'package:turf_application/constants.dart';
import 'package:turf_application/screens/home_screen.dart'; // adjust import

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  // Controllers
  late final AnimationController _scaleController;
  late final AnimationController _checkController;
  late final AnimationController _textController;
  late final AnimationController _pulseController;

  // Animations
  late final Animation<double> _scaleAnim;
  late final Animation<double> _checkAnim;
  late final Animation<double> _fadeSlideAnim;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    // 1. Box pops in
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // 2. Check circle scales in
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _checkAnim = CurvedAnimation(
      parent: _checkController,
      curve: Curves.easeOutBack,
    );

    // 3. Text fades + slides up
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeSlideAnim = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    );

    // 4. Subtle pulse on the box (loops)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Chain animations
    _scaleController.forward().then((_) {
      _checkController.forward().then((_) {
        _textController.forward();
      });
    });

    // Auto-navigate after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _checkController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Animated box ──
            ScaleTransition(
              scale: _scaleAnim,
              child: AnimatedBuilder(
                animation: _pulseAnim,
                builder: (_, child) => Transform.scale(
                  scale: _pulseAnim.value,
                  child: child,
                ),
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    // ── Animated check circle ──
                    child: ScaleTransition(
                      scale: _checkAnim,
                      child: Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: kPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: kDark,
                          size: 44,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Animated text ──
            AnimatedBuilder(
              animation: _fadeSlideAnim,
              builder: (_, child) => Opacity(
                opacity: _fadeSlideAnim.value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - _fadeSlideAnim.value)),
                  child: child,
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    'SUCCESS !',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: kPrimary,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your journey to peak performance starts now.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
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
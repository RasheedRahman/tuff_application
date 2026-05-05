import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// App Colors
// ─────────────────────────────────────────────
const kPrimary = Color(0xFFFAC00C); // golden yellow
const kLight   = Color(0xFFFEEDBB); // soft cream yellow
const kDark    = Color(0xFF2B2520); // near-black brown
const kWhite   = Colors.white;

// ─────────────────────────────────────────────
// Shared Widgets
// ─────────────────────────────────────────────

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        letterSpacing: 1.1,
      ),
    );
  }
}

class AuthInputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefix;

  const AuthInputField({
    super.key,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: kLight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          if (prefix != null) ...[
            const SizedBox(width: 16),
            prefix!,
            const SizedBox(width: 10),
          ] else
            const SizedBox(width: 20),
          Expanded(
            child: TextField(
              obscureText: obscure,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                TextStyle(color: Colors.grey.shade400, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffix != null) suffix!,
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }
}

class AuthOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AuthOutlineButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}

// Google 'G' icon painted manually
class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 24),
      painter: _GooglePainter(),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final blue = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.18;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
        -0.3, 3.8, false, blue);

    final blueFill = Paint()..color = const Color(0xFF4285F4);
    canvas.drawRect(
        Rect.fromLTWH(cx, cy - size.height * 0.09, r * 0.72, size.height * 0.18),
        blueFill);

    final red = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.18;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
        -1.1, 1.0, false, red);

    final green = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.18;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
        0.5, 1.2, false, green);

    final yellow = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.18;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
        1.7, 1.5, false, yellow);
  }

  @override
  bool shouldRepaint(_) => false;
}
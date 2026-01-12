import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const FooterSection({super.key, required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF689F38), Color(0xFF8BC34A)]),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: onPressed,
          child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
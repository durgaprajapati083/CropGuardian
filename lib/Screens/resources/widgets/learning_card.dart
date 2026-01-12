import 'package:flutter/material.dart';
class LearningCard extends StatelessWidget {
  final String title;
  final String hindi;

  const LearningCard({super.key, required this.title, required this.hindi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Container(
            height: 60, width: 60,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.play_circle_rounded, color: Colors.green, size: 40),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text(hindi, style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SchemeCard extends StatelessWidget {
  final String title, hindi, tag, description;
  final Widget button;

  const SchemeCard({super.key, required this.title, required this.hindi, required this.tag, required this.description, required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                  child: Text(tag, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const SizedBox(height: 10),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(hindi, style: const TextStyle(color: Colors.green, fontSize: 14)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(color: Colors.black54, height: 1.3)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
            child: button,
          )
        ],
      ),
    );
  }
}
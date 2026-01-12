import 'dart:ffi';

import 'package:flutter/material.dart';

class SchemeCard extends StatelessWidget {
  final String title;
  final String hindi;
  final String tag;
  final String description;
  late Widget button;

   SchemeCard({
    super.key,
    required this.title,
    required this.hindi,
    required this.tag,
    required this.description,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            hindi,
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          Text(description),
          const SizedBox(height: 12),
          Column(children: [button],)
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../models/organic_item.dart';

class OrganicSolutionCard extends StatelessWidget {
  final OrganicItem item;

  const OrganicSolutionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: Image.network(item.imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFC6FF00), borderRadius: BorderRadius.circular(10)),
                      child: Text(item.category, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _infoRow("Problem", item.problem, Colors.red),
                _infoRow("Symptoms", item.symptoms, Colors.orange[800]!),
                const Divider(height: 30),
                const Text("✅ SOLUTION", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                Text(item.solution, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 15),
                const Text("🌿 ORGANIC PESTICIDE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                Text(item.pesticide, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: RichText(
        text: TextSpan(style: const TextStyle(color: Colors.black, fontSize: 14), children: [
          TextSpan(text: "$label: ", style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          TextSpan(text: value),
        ]),
      ),
    );
  }
}
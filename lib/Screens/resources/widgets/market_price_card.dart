import 'package:flutter/material.dart';

class MarketPriceCard extends StatelessWidget {
  final String crop, price;
  const MarketPriceCard({super.key, required this.crop, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.green.shade50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(crop, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF1B5E20), fontSize: 18)),
        ],
      ),
    );
  }
}
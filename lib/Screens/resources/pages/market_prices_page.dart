import 'package:flutter/material.dart';
import '../widgets/app_footer.dart';
import '../widgets/market_price_card.dart';

class MarketPricesPage extends StatelessWidget {
  final String searchQuery;
  const MarketPricesPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"crop": "Wheat / गेहूं", "price": "₹2,125"},
      {"crop": "Rice / चावल", "price": "₹1,940"},
      {"crop": "Corn / मक्का", "price": "₹1,850"},
      {"crop": "Potato / आलू", "price": "₹1,200"},
    ];

    final filteredList = data.where((item) {
      return item['crop']!.toLowerCase().contains(searchQuery);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // Using ListView.shrinkWrap to allow it to sit above the footer
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            itemBuilder: (context, index) => MarketPriceCard(
              crop: filteredList[index]['crop']!,
              price: filteredList[index]['price']!,
            ),
          ),
          const SizedBox(height: 40),
          const AppFooter(), // Footer added here
        ],
      ),
    );
  }
}
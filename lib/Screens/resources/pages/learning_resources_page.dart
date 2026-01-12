import 'package:flutter/material.dart';
import '../widgets/app_footer.dart';
import '../widgets/learning_card.dart';

class LearningResourcesPage extends StatelessWidget {
  final String searchQuery;
  const LearningResourcesPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lessons = [
      {"title": "Organic Farming", "hindi": "जैविक खेती"},
      {"title": "Drip Irrigation", "hindi": "ड्रिप सिंचाई"},
    ];

    final filteredLessons = lessons.where((lesson) {
      return lesson['title']!.toLowerCase().contains(searchQuery);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredLessons.length,
            itemBuilder: (context, index) => LearningCard(
              title: filteredLessons[index]['title']!,
              hindi: filteredLessons[index]['hindi']!,
            ),
          ),
          const SizedBox(height: 40),
          const AppFooter(), // Footer added here
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../widgets/app_footer.dart';
import '../widgets/learning_card.dart';

class LearningResourcesPage extends StatelessWidget {
  final String searchQuery;

  const LearningResourcesPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lessons = [
      {
        "title": "Organic Agriculture",
        "hindi": "जैविक कृषि",
        "url":"https://youtu.be/wougJaN_Ha0?si=rliHbfmxFLLEuXGv",
      },
      {
        "title": "Start a Small Farm",
        "hindi": "एक छोटा खेत शुरू करें",
        "url":"https://youtu.be/heTxEsrPVdQ?si=a7bCXUIlRjfvBjM8",
      },
      {
        "title": "Small field Big Farming",
        "hindi": "छोटा खेत बड़ी खेतीें",
        "url":"https://youtu.be/JYXvtIOthMM?si=Q5n3MgWO3DGgcjXl",
      },

      {
        "title": "Organic Farming",
        "hindi": "जैविक खेती",
      "url":"https://youtu.be/wougJaN_Ha0?si=gsP5TzpxTFWeZlTi",
      },
      {
        "title": "Drip Irrigation",
        "hindi": "ड्रिप सिंचाई",
        "url": "https://youtu.be/Vof1GmL2DAQ?si=sZADC38-XT4SaTq2",
      },
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
              videoUrl: filteredLessons[index]['url']!,
            ),
          ),
          const SizedBox(height: 40),
          const AppFooter(), // Footer added here
        ],
      ),
    );
  }
}

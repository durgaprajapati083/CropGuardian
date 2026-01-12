import 'package:croupguardiandurgaprajapati/webviewscreen.dart';
import 'package:flutter/material.dart';

import '../widgets/app_footer.dart';
import '../widgets/scheme_card.dart';

class GovernmentSchemesPage extends StatelessWidget {
  final String searchQuery; // Receive search query from ResourcesScreen

  const GovernmentSchemesPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    // 1. DATA SOURCE (Kept exactly as your original backend/URLs)
    final List<Map<String, dynamic>> allSchemes = [
      {
        "title": "PM-KISAN Scheme",
        "hindi": "पीएम किसान योजना",
        "tag": "Financial Support",
        "desc": "Direct income support of ₹6000 per year to all farmer families.",
        "url": "https://pmkisan.gov.in/",
      },
      {
        "title": "Pradhan Mantri Fasal Bima Yojana",
        "hindi": "प्रधानमंत्री फसल बीमा योजना",
        "tag": "Insurance",
        "desc": "Crop insurance scheme to protect farmers against crop loss.",
        "url": "https://pmfby.gov.in/",
      },
      {
        "title": "Soil Health Card Scheme",
        "hindi": "मृदा स्वास्थ्य कार्ड योजना",
        "tag": "Agricultural Support",
        "desc": "Provides soil health cards with crop-wise recommendations.",
        "url": "https://soilhealth.dac.gov.in/home",
      },
    ];

    // 2. SEARCH FILTER LOGIC (Filters by English or Hindi name)
    final filteredList = allSchemes.where((scheme) {
      final name = scheme['title'].toString().toLowerCase();
      final hindi = scheme['hindi'].toString().toLowerCase();
      return name.contains(searchQuery) || hindi.contains(searchQuery);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 15),

          // 3. GENERATE FILTERED CARDS
          if (filteredList.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 50, color: Colors.green.withOpacity(0.5)),
                  const SizedBox(height: 10),
                  const Text("No schemes found / कोई योजना नहीं मिली",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          else
            ...filteredList.map((scheme) {
              return SchemeCard(
                title: scheme['title'],
                hindi: scheme['hindi'],
                tag: scheme['tag'],
                description: scheme['desc'],
                button: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            url: scheme['url'],
                            title: scheme['title'].toString().toUpperCase(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.open_in_new, size: 18, color: Colors.white),
                    label: const Text("LEARN MORE / जानकारी प्राप्त करें",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20), // Premium Dark Green
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),

          const SizedBox(height: 30),

          // ✅ FOOTER KEPT AS IT IS
          const AppFooter(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
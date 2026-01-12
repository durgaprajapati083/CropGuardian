import 'package:croupguardiandurgaprajapati/webviewscreen.dart';
import 'package:flutter/material.dart';

import '../widgets/app_footer.dart';
import '../widgets/scheme_card.dart';

class GovernmentSchemesPage extends StatelessWidget {
  const GovernmentSchemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 10),

          SchemeCard(
            title: "PM-KISAN Scheme",
            hindi: "पीएम किसान योजना",
            tag: "Financial Support",
            description:
                "Direct income support of ₹6000 per year to all farmer families.",
            button: ElevatedButton.icon(
              onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                          url: "https://pmkisan.gov.in/",
                          title: "PM KISHAN SCHEME",
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text("Learn More"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SchemeCard(
            title: "Pradhan Mantri Fasal Bima Yojana",
            hindi: "प्रधानमंत्री फसल बीमा योजना",
            tag: "Insurance",
            description:
                "Crop insurance scheme to protect farmers against crop loss.",
            button: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                      url: "https://pmfby.gov.in/",
                      title: "PMFBY",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text("Learn More"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SchemeCard(
            title: "Soil Health Card Scheme",
            hindi: "मृदा स्वास्थ्य कार्ड योजना",
            tag: "Agricultural Support",
            description:
                "Provides soil health cards with crop-wise recommendations.",
            button: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                      url: "https://soilhealth.dac.gov.in/home",
                      title: "Soil Health Card",
                    ),
                  ),
                );
              },

              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text("Learn More"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ✅ FOOTER GOES HERE
          const AppFooter(),
        ],
      ),
    );
  }
}

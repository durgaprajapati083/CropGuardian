import 'package:flutter/material.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Elegant Header with Dual Language
          const Text(
            "Powerful Features",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B5E20),
              letterSpacing: -0.5,
            ),
          ),
          const Text(
            "किसानों के लिए शक्तिशाली सुविधाएं",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 25),

          _buildMultiColorCard(
            title: "AI Crop Diagnosis",
            hindiTitle: "एआई फसल निदान",
            description: "Instant disease and pest identification with 85% accuracy.",
            icon: Icons.auto_awesome_rounded,
            // Gradient: Deep Green to Lime
            gradientColors: [const Color(0xFF1B5E20), const Color(0xFF4CAF50)],
          ),

          _buildMultiColorCard(
            title: "Community Support",
            hindiTitle: "सामुदायिक सहायता",
            description: "Connect with fellow farmers and share valuable experiences.",
            icon: Icons.groups_3_rounded,
            // Gradient: Deep Orange to Amber
            gradientColors: [const Color(0xFFE65100), const Color(0xFFFFB300)],
          ),

          _buildMultiColorCard(
            title: "Resource Library",
            hindiTitle: "संसाधन पुस्तकालय",
            description: "Access government schemes and market prices in your language.",
            icon: Icons.menu_book_rounded,
            // Gradient: Royal Blue to Sky Blue
            gradientColors: [const Color(0xFF0D47A1), const Color(0xFF42A5F5)],
          ),

          _buildMultiColorCard(
            title: "Organic Solutions",
            hindiTitle: "जैविक समाधान",
            description: "Personalized organic treatment plans for sustainable farming.",
            icon: Icons.eco_rounded,
            // Gradient: Teal to Mint
            gradientColors: [const Color(0xFF004D40), const Color(0xFF26A69A)],
          ),
        ],
      ),
    );
  }

  Widget _buildMultiColorCard({
    required String title,
    required String hindiTitle,
    required String description,
    required IconData icon,
    required List<Color> gradientColors,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 140, // Fixed height for a uniform grid feel
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decorative Circle for visual flair
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Icon Section with Glass effect
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(icon, color: Colors.white, size: 35),
                ),
                const SizedBox(width: 20),
                // Content Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        hindiTitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
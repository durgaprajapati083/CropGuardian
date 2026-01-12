import 'package:flutter/material.dart';

class TrustSection extends StatelessWidget {
  const TrustSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 16),
            child: Text(
              "Why Farmers Trust Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          // 2x2 Grid using Rows and Columns for better layout control
          Column(
            children: [
              Row(
                children: [
                  _buildTrustCard(
                    title: "85% Accuracy",
                    subtitle: "Diagnosis",
                    icon: Icons.biotech_rounded,
                    colors: [const Color(0xFF66BB6A), const Color(0xFF43A047)],
                  ),
                  const SizedBox(width: 12),
                  _buildTrustCard(
                    title: "Multilingual",
                    subtitle: "Hindi & More",
                    icon: Icons.translate_rounded,
                    colors: [const Color(0xFFFFA726), const Color(0xFFFB8C00)],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildTrustCard(
                    title: "Expert Guide",
                    subtitle: "24/7 Support",
                    icon: Icons.psychology_rounded,
                    colors: [const Color(0xFF42A5F5), const Color(0xFF1E88E5)],
                  ),
                  const SizedBox(width: 12),
                  _buildTrustCard(
                    title: "Community",
                    subtitle: "Farmer Driven",
                    icon: Icons.groups_rounded,
                    colors: [const Color(0xFF26A69A), const Color(0xFF00897B)],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> colors,
  }) {
    return Expanded(
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
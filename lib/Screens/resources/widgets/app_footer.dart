import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  // Function to open social links safely
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $urlString");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1B5E20), // Your Deep Nature Green
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Branding Section
            Row(
              children: [
                const Icon(Icons.eco, color: Color(0xFFC6FF00), size: 28),
                const SizedBox(width: 10),
                const Text(
                  "CropGuardian",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // YOUR REQUESTED TEXT ADDED HERE
            const Text(
              "Empowering the hands that feed us with smart technology.",
              style: TextStyle(color: Colors.white60, fontSize: 13),
            ),

            const SizedBox(height: 30),
            const Divider(color: Colors.white10),
            const SizedBox(height: 25),

            // Social Media Header
            const Text(
              "CONNECT WITH THE DEVELOPER",
              style: TextStyle(
                  color: Color(0xFFC6FF00),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
              ),
            ),
            const SizedBox(height: 20),

            // OFFICIAL SOCIAL ICONS ROW
            Row(
              children: [
                _socialIcon(
                  icon: FontAwesomeIcons.instagram,
                  url: "https://www.instagram.com/durgaprajapati067?igsh=MTgwMTducnk5Z3JiNA==",
                ),
                _socialIcon(
                  icon: FontAwesomeIcons.facebook,
                  url: "https://www.facebook.com/share/17e6uaX4oU/",
                ),
                _socialIcon(
                  icon: FontAwesomeIcons.linkedin,
                  url: "https://www.linkedin.com/in/durga-prajapati-0692b1247?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
                ),
                _socialIcon(
                  icon: FontAwesomeIcons.github,
                  url: "https://github.com/durgaprajapati083",
                ),
              ],
            ),

            const SizedBox(height: 35),

            // Contact Mini Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  _contactRow(Icons.email_outlined, "durgaprajapati703@gmail.com"),
                  const SizedBox(height: 15),
                  _contactRow(Icons.phone_android_outlined, "+91 7054484937\n+977 9806935942"),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Center(
              child: Text(
                "© 2026 CropGuardian • Built with care for Farmers",
                style: TextStyle(color: Colors.white24, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI HELPER FOR SOCIAL ICONS ---
  Widget _socialIcon({required IconData icon, required String url}) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFC6FF00), size: 18),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}
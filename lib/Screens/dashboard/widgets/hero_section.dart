import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../community_screen/community_screen.dart';
import '../../diagnosis_screen/diagnosis_screen.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
              child: Image.network(
                'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=2000&auto=format&fit=crop',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Deep Nature Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    const Color(0xFF1B5E20).withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),

          // 3. Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _badge(),
                const SizedBox(height: 25),

                // --- CONTINUOUS TYPING ANIMATION ---
                SizedBox(
                  height: 110,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'AI-Powered Farming\nFor Every Farmer',
                        speed: const Duration(milliseconds: 100),
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      TypewriterAnimatedText(
                        'AI-Powered Farming\nFor Every Farmer',
                        speed: const Duration(milliseconds: 100),
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFC6FF00), // Changes color on loop
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "हर किसान के लिए एआई-संचालित खेती",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFA5D6A7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Intelligent crop disease diagnosis and expert guidance in your language.",
                  style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 35),
                _primaryButton(),
                const SizedBox(height: 12),
                _secondaryButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFE65100)]),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 8)],
      ),
      child: const Text(
        "★ Trusted by 4000+ Farmers",
        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _primaryButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC6FF00).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => Get.to(() => const DiagnosisScreen()),
        icon: const Icon(Icons.psychology_outlined, color: Colors.black),
        label: const Text("START AI DIAGNOSIS", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC6FF00),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }

  Widget _secondaryButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Get.to(() => const CommunityScreen()),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: const Text("JOIN COMMUNITY / समुदाय", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
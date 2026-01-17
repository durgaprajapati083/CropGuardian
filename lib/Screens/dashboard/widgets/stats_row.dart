import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/stats_controller.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller to start listening to Firestore
    final StatsController stats = Get.put(StatsController());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      // Obx listens to the .obs variables in the controller and rebuilds automatically
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            value: stats.diagnosesCount.value.toString(),
            label: "Diagnoses",
            icon: Icons.troubleshoot,
            color: const Color(0xFF2E7D32),
          ),
          _StatItem(
            value: stats.farmersCount.value.toString(),
            label: "Farmers",
            icon: Icons.people_alt_rounded,
            color: const Color(0xFFF57C00),
          ),
          _StatItem(
            value: "${stats.accuracyValue.value.toInt()}%",
            label: "Accuracy",
            icon: Icons.verified_rounded,
            color: const Color(0xFF1976D2),
          ),
        ],
      )),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Clean the value for animation (removes % if present)
    int endValue = int.tryParse(value.replaceAll('%', '')) ?? 0;

    return Column(
      children: [
        // Circular Icon Badge with soft colored background
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 12),

        // Animated Counter for a "Exciting" premium feel
        TweenAnimationBuilder(
          tween: IntTween(begin: 0, end: endValue),
          duration: const Duration(seconds: 2),
          builder: (context, int val, child) {
            return Text(
              value.contains('%') ? "$val%" : "$val",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
                letterSpacing: -0.5,
              ),
            );
          },
        ),

        // Label with uppercase for a professional dashboard look
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Authentication/login_screen.dart';
import '../Screens/community_screen/community_screen.dart';
import '../Screens/dashboard/dashboard_screen.dart';
import '../Screens/diagnosis_screen/diagnosis_screen.dart';
import '../Screens/farmer_profile/farmer_profile_screen.dart';
import '../Screens/resources/resource_screen.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;

  const AppDrawer({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
      ),
      child: Stack(
        children: [
          // 1. Background Decorative Gradient Strip
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFFC6FF00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          Column(
            children: [
              _buildModernHeader(context),
              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildGradientTile(
                        context,
                        title: "Dashboard",
                        hindi: "डैशबोर्ड",
                        icon: Icons.dashboard_customize_rounded,
                        index: 0,
                        onTap: () => Get.offAll(() => const DashboardScreen()),
                      ),
                      _buildGradientTile(
                        context,
                        title: "AI Diagnosis",
                        hindi: "फसल रोग निदान",
                        icon: Icons.center_focus_strong_rounded,
                        index: 1,
                        onTap: () => Get.to(() => const DiagnosisScreen()),
                      ),
                      _buildGradientTile(
                        context,
                        title: "Community",
                        hindi: "किसान समुदाय",
                        icon: Icons.forum_rounded,
                        index: 2,
                        onTap: () => Get.to(() => const CommunityScreen()),
                      ),
                      _buildGradientTile(
                        context,
                        title: "Resources",
                        hindi: "संसाधन केंद्र",
                        icon: Icons.auto_stories_rounded,
                        index: 3,
                        onTap: () => Get.to(() => const ResourcesScreen()),
                      ),
                    ],
                  ),
                ),
              ),

              _buildBottomProfile(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, bottom: 40, right: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
            child: const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Icon(Icons.eco_rounded, color: Color(0xFF1B5E20), size: 40),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "CropGuardian",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const Text(
            "Smart Agriculture • कृषि रक्षक",
            style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientTile(
      BuildContext context, {
        required String title,
        required String hindi,
        required IconData icon,
        required int index,
        required VoidCallback onTap,
      }) {
    bool isActive = selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: isActive
            ? const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : null,
        boxShadow: isActive
            ? [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
            : [],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey[700],
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          hindi,
          style: TextStyle(
            color: isActive ? Colors.white70 : Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: isActive ? Colors.white : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildBottomProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => Get.to(() => FarmerProfileScreen(userId: 'unique_id')),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.withOpacity(0.1)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFC6FF00),
                    child: Icon(Icons.person_rounded, color: Colors.black),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("My Profile", style: TextStyle(fontWeight: FontWeight.w900)),
                      Text("मेरा प्रोफाइल", style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.settings_suggest_rounded, color: Colors.grey[400]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextButton.icon(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: const Icon(Icons.power_settings_new_rounded, color: Colors.red),
            label: const Text(
              "Logout • लॉग आउट",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
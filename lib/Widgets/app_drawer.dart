
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

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
      elevation: 10,
      child: SafeArea(
        child: Column(
          children: [
            _header(context),
            const SizedBox(height: 20),

            _drawerItem(
              context,
              title: "Home",
              subtitle: "होम",
              // isActive: selectedIndex == 0,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
              },
            ),

            _drawerItem(
              context,
              title: "Diagnose",
              subtitle: "निदान",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DiagnosisScreen()));
              },
            ),

            _drawerItem(
              context,
              title: "Community",
              subtitle: "समुदाय",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CommunityScreen()));
              },
            ),

            _drawerItem(
              context,
              title: "Resources",
              subtitle: "संसाधन",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResourcesScreen()));
              },
            ),

            const Spacer(),

            _profileButton(context),
            const SizedBox(height: 14),
            _logoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// HEADER
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green,
            child: Icon(Icons.eco, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "CropGuardian",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                "कृषि रक्षक",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  /// DRAWER ITEM
  Widget _drawerItem(
      BuildContext context, {
        required String title,
        required String subtitle,
        bool isActive = false,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
              colors: [Color(0xFF00C853), Color(0xFF00BFA5)],
            )
                : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isActive ? Colors.white70 : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// PROFILE BUTTON
  Widget _profileButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Get.to(FarmerProfileScreen(userId: '',));
          },
          icon: const Icon(Icons.person),
          label: const Text("My Profile / मेरा प्रोफ़ाइल"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }

  /// LOGOUT BUTTON
  Widget _logoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            Get.to(()=>LoginScreen());
          },
          icon: const Icon(Icons.logout),
          label: const Text("Logout / लॉग आउट"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}

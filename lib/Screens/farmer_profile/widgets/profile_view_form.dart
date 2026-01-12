import 'package:flutter/material.dart';
import '../model/farmer_profile_model.dart'; // Ensure path is correct

class ProfileViewForm extends StatelessWidget {
  final FarmerProfileModel profile;

  const ProfileViewForm({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section 1: Registration Details
        _buildInfoCard(
          title: "Account Information",
          children: [
            _buildViewRow("Full Name", profile.userName, Icons.person_outline),
            _buildViewRow("Phone", profile.userPhone, Icons.phone_android),
            _buildViewRow("Email", profile.userEmail, Icons.email_outlined),
          ],
        ),

        const SizedBox(height: 20),

        // Section 2: Farm & Additional Details
        _buildInfoCard(
          title: "Additional Information",
          children: [
            _buildViewRow("Location", profile.location ?? "Not set", Icons.location_on_outlined),
            _buildViewRow("Language", profile.language ?? "English", Icons.translate),
            _buildViewRow("Farm Size", profile.farmSize ?? "Not set", Icons.landscape_outlined),
            _buildViewRow("Crops Grown", profile.cropsGrown ?? "Not set", Icons.grass_outlined),
          ],
        ),
      ],
    );
  }

  // A card wrapper to group items with a soft shadow
  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const Divider(height: 30, thickness: 0.8),
          ...children,
        ],
      ),
    );
  }

  // Individual Row for View Mode (No TextFields here)
  Widget _buildViewRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Icon Box
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F8E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.green[700], size: 20),
          ),
          const SizedBox(width: 16),
          // Label and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
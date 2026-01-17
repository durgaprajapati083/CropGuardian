import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croupguardiandurgaprajapati/Screens/farmer_profile/utils/profile_completion_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';
import 'model/farmer_profile_model.dart';
import 'widgets/footer_section.dart';
import 'widgets/profile_header.dart';
import 'widgets/status_card.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key, required String userId});

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "CropGuardian",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF689F38),
        elevation: 0,
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white)),
        // ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("Profile not found. Please register."),
            );
          }

          // Convert Firestore data to our Model
          final profile = FarmerProfileModel.fromMap(
            snapshot.data!.data() as Map<String, dynamic>,
            uid,
          );

          // --- ADD THESE TWO LINES HERE ---
          double progress = ProfileCompletionUtil.calculate(profile);
          bool isVerified = progress >= 1.0; // 1.0 means 100%
          // --------------------------------

          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(
                  profile: profile,
                  onImagePickTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),

                // Fix the typo "constPadding" to "Padding"
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const StatusCard(
                        title: "Active",
                        subtitle: "Status",
                        icon: Icons.flash_on,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 15),
                      StatusCard(
                        title: "Member",
                        // Now "isVerified" will work correctly
                        subtitle: isVerified ? "Verified" : "Not Verified",
                        icon: Icons.verified_user,
                        color: isVerified ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoSection(
                        title: "Account Information",
                        items: [
                          _buildViewItem(
                            "Full Name",
                            profile.userName,
                            Icons.person_outline,
                          ),
                          _buildViewItem(
                            "Phone Number",
                            profile.userPhone,
                            Icons.phone_android,
                          ),
                          _buildViewItem(
                            "Email Address",
                            profile.userEmail,
                            Icons.email_outlined,
                          ),
                          _buildViewItem(
                            "Location",
                            profile.location ?? "Not set",
                            Icons.location_on_outlined,
                          ),
                          _buildViewItem(
                            "Language",
                            profile.language ?? "English",
                            Icons.translate,
                          ),
                          _buildViewItem(
                            "Farm Size",
                            profile.farmSize ?? "Not set",
                            Icons.landscape_outlined,
                          ),
                          _buildViewItem(
                            "Crops Grown",
                            profile.cropsGrown ?? "Not set",
                            Icons.grass_outlined,
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // 4. Gradient "Edit Profile" Button at the bottom
      bottomSheet: FooterSection(
        buttonText: "Edit Profile / प्रोफ़ाइल संपादित करें",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditProfileScreen()),
          );
        },
      ),
    );
  }

  // Helper to build the white container for info items
  Widget _buildInfoSection({
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 30, thickness: 1),
          ...items,
        ],
      ),
    );
  }

  // Helper to build each individual view-only row
  Widget _buildViewItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align to top for multi-line text
        children: [
          Icon(icon, color: Colors.green[600], size: 22),
          const SizedBox(width: 15),

          // Use Expanded here to let the text know how much space it has
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
                  value.isEmpty ? " " : value,
                  // softWrap and overflow handle the long text beauty
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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

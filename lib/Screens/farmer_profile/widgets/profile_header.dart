import 'dart:io';
import 'package:flutter/material.dart';
import '../model/farmer_profile_model.dart';
import '../utils/profile_completion_util.dart';

class ProfileHeader extends StatelessWidget {
  final FarmerProfileModel profile;
  final File? localImageFile;
  final VoidCallback onImagePickTap;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.localImageFile,
    required this.onImagePickTap,
  });

  @override
  Widget build(BuildContext context) {
    double progress = ProfileCompletionUtil.calculate(profile);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF689F38), Color(0xFF8BC34A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              GestureDetector(
                onTap: onImagePickTap,
                child: CircleAvatar(
                  radius: 54,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: localImageFile != null
                        ? FileImage(localImageFile!)
                        : (profile.profileImageUrl != null
                        ? NetworkImage(profile.profileImageUrl!)
                        : null) as ImageProvider?,
                    child: (localImageFile == null && profile.profileImageUrl == null)
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            "Complete Your Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            "Profile Completion: ${(progress * 100).toInt()}%",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'model/farmer_profile_model.dart';
import 'services/cloudinary_service.dart';
import 'services/firebase_profile_service.dart';
import 'widgets/footer_section.dart';
import 'widgets/profile_form.dart';
import 'widgets/profile_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseService = FirebaseProfileService();
  final _cloudinaryService = CloudinaryService();

  late TextEditingController name, email, phone, location, farmSize, crops;
  FarmerProfileModel? profile;
  File? imageFile;
  String? lang;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    location = TextEditingController();
    farmSize = TextEditingController();
    crops = TextEditingController();
    _load();
  }

  _load() async {
    profile = await _firebaseService.getUserProfile(
      FirebaseAuth.instance.currentUser!.uid,
    );
    if (profile != null) {
      name.text = profile!.userName;
      email.text = profile!.userEmail;
      phone.text = profile!.userPhone;
      location.text = profile!.location ?? "";
      farmSize.text = profile!.farmSize ?? "";
      crops.text = profile!.cropsGrown ?? "";
      lang = profile!.language;
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF689F38),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(
              profile: profile!,
              localImageFile: imageFile,
              onImagePickTap: () async {
                XFile? f = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (f != null) setState(() => imageFile = File(f.path));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ProfileForm(
                formKey: _formKey,
                nameController: name,
                emailController: email,
                phoneController: phone,
                locationController: location,
                farmSizeController: farmSize,
                cropsController: crops,
                selectedLanguage: lang,
                onLanguageChanged: (v) => setState(() => lang = v),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterSection(
        buttonText: "Save Details",
        onPressed: () {
          _save();
        },
      ),
    );
  }

  _save() async {
    if (!_formKey.currentState!.validate()) return;

    // Show a loading dialog so the user knows the upload is happening
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 1. Get the existing URL or null
      String? url = profile?.profileImageUrl;

      // 2. If a new image was picked, upload it and get the NEW Cloudinary URL
      if (imageFile != null) {
        url = await _cloudinaryService.uploadImage(imageFile!);
      }

      // 3. Create the updated model with the NEW URL
      var updated = FarmerProfileModel(
        userId: profile!.userId,
        userName: name.text,
        userPhone: phone.text,
        userEmail: email.text,
        location: location.text,
        language: lang,
        farmSize: farmSize.text,
        cropsGrown: crops.text,
        profileImageUrl: url, // This will now correctly save the Cloudinary URL
      );

      // 4. Update Firestore
      await _firebaseService.updateUserProfile(updated);

      // 5. Hide the loading dialog
      if (mounted) Navigator.pop(context);

      // 6. Go back to the profile screen
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated Successfully!")),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context); // Hide loading on error
      debugPrint("Update Error: $e");
    }
  }
}

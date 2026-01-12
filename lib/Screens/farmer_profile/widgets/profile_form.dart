import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController locationController;
  final TextEditingController farmSizeController;
  final TextEditingController cropsController;
  final String? selectedLanguage;
  final Function(String?) onLanguageChanged;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.locationController,
    required this.farmSizeController,
    required this.cropsController,
    this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Registration Details (Read Only)"),
          _buildModernField(
            label: "Full Name / पूरा नाम",
            icon: Icons.person_outline,
            controller: nameController,
            isReadOnly: true,
          ),
          _buildModernField(
            label: "Email Address / ईमेल",
            icon: Icons.email_outlined,
            controller: emailController,
            isReadOnly: true,
          ),
          _buildModernField(
            label: "Phone Number / फोन नंबर",
            icon: Icons.phone_android_outlined,
            controller: phoneController,
            isReadOnly: true,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
          ),

          _buildSectionTitle("Additional Details (Editable)"),
          _buildModernField(
            label: "Location / स्थान",
            icon: Icons.location_on_outlined,
            controller: locationController,
            isReadOnly: false,
            hint: "Enter your village or city",
          ),
          _buildLanguageDropdown(),
          _buildModernField(
            label: "Farm Size / खेत का आकार",
            icon: Icons.landscape_outlined,
            controller: farmSizeController,
            isReadOnly: false,
            hint: "e.g. 5 Acres",
          ),
          _buildModernField(
            label: "Crops Grown / उगाई जाने वाली फसलें",
            icon: Icons.grass_outlined,
            controller: cropsController,
            isReadOnly: false,
            hint: "e.g. Wheat, Rice, Tomato",
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.green[800],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildModernField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool isReadOnly,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            readOnly: isReadOnly,
            style: TextStyle(
              color: isReadOnly ? Colors.grey[600] : Colors.black87,
              fontWeight: isReadOnly ? FontWeight.w400 : FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.green[600], size: 22),
              filled: true,
              fillColor: isReadOnly ? const Color(0xFFF5F5F5) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.green, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Preferred Language / पसंदीदा भाषा",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.green),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.language, color: Colors.green, size: 22),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ["English", "Hindi", "Marathi", "Punjabi", "Tamil", "Telugu"]
                .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                .toList(),
            onChanged: onLanguageChanged,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../core/constants.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSelector({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: AppConstants.supportedLanguages.map((language) {
        final isSelected = language == selectedLanguage;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              onPressed: () => onLanguageChanged(language),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.green : Colors.grey.shade300,
                foregroundColor: isSelected ? Colors.white : Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(language),
            ),
          ),
        );
      }).toList(),
    );
  }
}
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const LanguageSelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['English', 'Hindi', 'Kannada'].map((lang) {
        final active = selected == lang;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(lang),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 45,
              decoration: BoxDecoration(
                color: active ? Colors.green : Colors.white,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  lang,
                  style: TextStyle(
                    color: active ? Colors.white : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

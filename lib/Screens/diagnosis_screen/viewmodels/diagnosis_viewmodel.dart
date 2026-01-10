import 'dart:io';
import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../services/translator_service.dart';
import '../services/tts_service.dart';

class DiagnosisViewModel extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();

  File? imageFile;
  String? uploadedImageUrl; // ✅ THIS WAS MISSING
  bool isLoading = false;
  String result = '';

  /// SET IMAGE AFTER PICKING
  void setImage(File file, String cloudinaryUrl) {
    imageFile = file;
    uploadedImageUrl = cloudinaryUrl;
    notifyListeners();
  }

  /// MAIN DIAGNOSIS METHOD
  Future<void> diagnoseCrop({
    required String imageUrl,
    required String description,
    required String language,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // 1️⃣ Get English result from Gemini
      final englishResult = await _geminiService.analyzeCrop(
        imageUrl: imageUrl,
        description: description,
        language: 'English',
      );

      // 2️⃣ Translate if needed
      if (language != 'English') {
        result = await TranslatorService.translate(
          englishResult,
          language,
        );
      } else {
        result = englishResult;
      }

      // 3️⃣ Speak result
      await TtsService.speak(result, language);
    } catch (e) {
      result = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
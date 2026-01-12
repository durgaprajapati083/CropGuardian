import 'dart:io';
import '../models/diagnosis_model.dart';
import 'cloudinary_service.dart';
import 'openrouter_service.dart';
import 'translator_service.dart';

class DiagnosisService {
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final OpenRouterService _openRouterService = OpenRouterService();
  final TranslatorService _translatorService = TranslatorService();

  Future<Map<String, dynamic>> performDiagnosis({
    required File imageFile,
    String? description,
    required String language,
  }) async {
    try {
      print('Uploading image...');
      final imageUrl = await _cloudinaryService.uploadImage(imageFile);
      if (imageUrl == null) {
        throw Exception('Failed to upload image');
      }
      print('Image uploaded: $imageUrl');

      print('Analyzing image...');
      final analysisText = await _openRouterService.analyzeImage(imageUrl, description);

      print('Parsing response...');
      final diagnosis = _openRouterService.parseDiagnosisResponse(analysisText);

      if (language != 'English') {
        print('Translating to $language...');
        final translatedDiagnosis = await _translatorService.translateDiagnosis(
          diagnosis.toJson(),
          language,
        );

        return {
          'success': true,
          'imageUrl': imageUrl,
          'diagnosis': DiagnosisModel.fromJson(translatedDiagnosis),
        };
      }

      return {
        'success': true,
        'imageUrl': imageUrl,
        'diagnosis': diagnosis,
      };
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
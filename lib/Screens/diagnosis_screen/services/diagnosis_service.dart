import 'dart:io';
import '../models/diagnosis_model.dart';
import 'cloudinary_service.dart';
import 'openrouter_service.dart';
import 'translator_service.dart';
// 1. ADD THESE IMPORTS
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiagnosisService {
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final OpenRouterService _openRouterService = OpenRouterService();
  final TranslatorService _translatorService = TranslatorService();
  // 2. INITIALIZE FIRESTORE
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

      DiagnosisModel finalDiagnosis = diagnosis;

      if (language != 'English') {
        print('Translating to $language...');
        final translatedDiagnosis = await _translatorService.translateDiagnosis(
          diagnosis.toJson(),
          language,
        );
        finalDiagnosis = DiagnosisModel.fromJson(translatedDiagnosis);
      }

      // --- 3. ADD THIS SECTION HERE TO SAVE TO FIREBASE ---
      // This is what makes the "Diagnoses" number increase on your dashboard!
      try {
        await _db.collection('diagnoses').add({
          ...finalDiagnosis.toJson(),
          'confidence': finalDiagnosis.confidenceScore,
          'imageUrl': imageUrl, // Save the image link too
          'userId': FirebaseAuth.instance.currentUser?.uid, // Link to the farmer
          'serverTimestamp': FieldValue.serverTimestamp(), // Used for real-time counting
        });
        print('Diagnosis successfully saved to Firestore!');
      } catch (dbError) {
        print('Database Error: $dbError');
        // We don't throw an error here so the user can still see their result
        // even if the database save fails.
      }
      // ---------------------------------------------------

      return {
        'success': true,
        'imageUrl': imageUrl,
        'diagnosis': finalDiagnosis,
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
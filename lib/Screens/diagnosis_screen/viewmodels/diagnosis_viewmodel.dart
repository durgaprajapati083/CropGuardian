import 'dart:io';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../models/diagnosis_model.dart';
import '../services/diagnosis_service.dart';
import '../services/tts_service.dart';

class DiagnosisViewModel extends ChangeNotifier {
  final DiagnosisService _diagnosisService = DiagnosisService();
  final TtsService _ttsService = TtsService();
  late stt.SpeechToText _speech;

  File? _selectedImage;
  String _description = '';
  String _selectedLanguage = 'English';
  DiagnosisModel? _diagnosis;
  String? _imageUrl;
  bool _isLoading = false;
  bool _isSpeaking = false;
  bool _isListening = false;
  String _errorMessage = '';

  // Getters
  File? get selectedImage => _selectedImage;
  String get description => _description;
  String get selectedLanguage => _selectedLanguage;
  DiagnosisModel? get diagnosis => _diagnosis;
  String? get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;
  bool get isSpeaking => _isSpeaking;
  bool get isListening => _isListening;
  String get errorMessage => _errorMessage;

  DiagnosisViewModel() {
    _initializeServices();

  }

  Future<void> _initializeServices() async {
    await _ttsService.initialize();
    _speech = stt.SpeechToText();
    await _speech.initialize();

    _ttsService.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  void setImage(File image) {
    _selectedImage = image;
    _diagnosis = null;
    _errorMessage = '';
    notifyListeners();
  }

  void setDescription(String desc) {
    _description = desc;
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    _ttsService.setLanguage(language);
    notifyListeners();
  }

  Future<void> performDiagnosis() async {
    if (_selectedImage == null) {
      _errorMessage = 'Please select an image first';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    _diagnosis = null;
    notifyListeners();

    try {
      final result = await _diagnosisService.performDiagnosis(
        imageFile: _selectedImage!,
        description: _description.isEmpty ? null : _description,
        language: _selectedLanguage,
      );

      if (result['success']) {
        _diagnosis = result['diagnosis'];
        _imageUrl = result['imageUrl'];
      } else {
        _errorMessage = result['error'] ?? 'Diagnosis failed';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleSpeech() async {
    if (_isSpeaking) {
      await _ttsService.stop();
      _isSpeaking = false;
    } else if (_diagnosis != null) {
      final textToSpeak = _buildSpeechText();
      await _ttsService.speak(textToSpeak);
      _isSpeaking = true;
    }
    notifyListeners();
  }

  String _buildSpeechText() {
    if (_diagnosis == null) return '';

    return '''
Crop Type: ${_diagnosis!.cropType}.
Detected Issue: ${_diagnosis!.detectedIssue}.
Severity: ${_diagnosis!.severity}.
Description: ${_diagnosis!.description}.
Solutions: ${_diagnosis!.solutions.join('. ')}.
Preventive Measures: ${_diagnosis!.preventiveMeasures.join('. ')}.
Pesticide: ${_diagnosis!.recommendedPesticides.join('. ')}.
confidence_score: ${_diagnosis!.confidenceScore}
''';
  }

  Future<void> toggleVoiceInput() async {
    if (_isListening) {
      await _speech.stop();
      _isListening = false;
    } else {
      if (await _speech.initialize()) {
        _isListening = true;
        notifyListeners();

        await _speech.listen(
          onResult: (result) {
            _description = result.recognizedWords;
            notifyListeners();
          },
          localeId: _getLocaleId(),
        );
      }
    }
    notifyListeners();
  }

  String _getLocaleId() {
    switch (_selectedLanguage) {
      case 'Hindi':
        return 'hi_IN';
      case 'Kannada':
        return 'kn_IN';
      default:
        return 'en_US';
    }
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}
import 'package:flutter_tts/flutter_tts.dart';
import '../core/constants.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  Future<void> initialize() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> setLanguage(String language) async {
    final languageCode = AppConstants.ttsLanguageCodes[language] ?? 'en-US';
    await _flutterTts.setLanguage(languageCode);
  }

  Future<void> speak(String text) async {
    if (_isSpeaking) {
      await stop();
    }
    _isSpeaking = true;
    await _flutterTts.speak(text);
  }

  Future<void> pause() async {
    await _flutterTts.pause();
    _isSpeaking = false;
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _isSpeaking = false;
  }

  bool get isSpeaking => _isSpeaking;

  void setCompletionHandler(Function() handler) {
    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      handler();
    });
  }
}
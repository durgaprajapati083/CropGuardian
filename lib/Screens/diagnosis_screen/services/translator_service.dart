import 'package:translator/translator.dart';
import '../core/constants.dart';

class TranslatorService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translate(String text, String targetLanguage) async {
    try {
      if (targetLanguage == 'English') {
        return text;
      }

      final languageCode = AppConstants.languageCodes[targetLanguage] ?? 'en';
      final translation = await _translator.translate(
        text,
        to: languageCode,
      );

      return translation.text;
    } catch (e) {
      print('Translation error: $e');
      return text;
    }
  }

  Future<Map<String, dynamic>> translateDiagnosis(
      Map<String, dynamic> diagnosis,
      String targetLanguage,
      ) async {
    if (targetLanguage == 'English') {
      return diagnosis;
    }

    try {
      final translated = <String, dynamic>{};

      for (var entry in diagnosis.entries) {
        if (entry.value is String) {
          translated[entry.key] = await translate(entry.value, targetLanguage);
        } else if (entry.value is List) {
          translated[entry.key] = await Future.wait(
            (entry.value as List).map((item) => translate(item.toString(), targetLanguage)),
          );
        } else {
          translated[entry.key] = entry.value;
        }
      }

      return translated;
    } catch (e) {
      print('Diagnosis translation error: $e');
      return diagnosis;
    }
  }
}
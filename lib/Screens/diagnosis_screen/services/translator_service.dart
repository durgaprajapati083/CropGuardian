import 'package:translator/translator.dart';

class TranslatorService {
  static final _translator = GoogleTranslator();

  static Future<String> translate(
      String text,
      String targetLanguage,
      ) async {
    final langCode = {
      'English': 'en',
      'Hindi': 'hi',
      'Kannada': 'kn',
    }[targetLanguage]!;

    final translation =
    await _translator.translate(text, to: langCode);

    return translation.text;
  }
}

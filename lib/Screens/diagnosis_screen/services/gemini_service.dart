import 'dart:convert';

import 'package:http/http.dart' as http;

/// This service uses OpenRouter (NOT Google Gemini direct API)
/// Model used:
/// meta-llama/llama-3.2-11b-vision-instruct (FREE & supports images)
class GeminiService {
  // 🔐 Your OpenRouter API key
  static const String _apiKey =
      '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';

  // 🌐 OpenRouter endpoint
  static const String _endpoint =
      'https://openrouter.ai/api/v1/chat/completions';

  /// Analyze crop image + user description
  Future<String> analyzeCrop({
    required String imageUrl,
    required String description,
    required String language,
  }) async {
    try {
      final prompt = _buildPrompt(
        description: description,
        language: language,
      );

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://cropguardian.app',
          'X-Title': 'CropGuardian',
        },
        body: jsonEncode({
          "model": "meta-llama/llama-3.2-11b-vision-instruct",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": prompt,
                },
                {
                  "type": "image_url",
                  "image_url": {
                    "url": imageUrl,
                  }
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'API Error ${response.statusCode}: ${response.body}',
        );
      }

      final data = jsonDecode(response.body);

      return data['choices'][0]['message']['content'];
    } catch (e) {
      throw Exception('Diagnosis failed: $e');
    }
  }

  /// Prompt builder (clean & controlled)
  String _buildPrompt({
    required String description,
    required String language,
  }) {
    return '''
You are an agricultural expert.

Analyze the crop image carefully and respond in $language.

User description:
$description

Provide:
1. Crop disease or issue name
2. Symptoms
3. Cause
4. Treatment (step by step)
5. Prevention tips

Keep the explanation simple for farmers.
''';
  }
}

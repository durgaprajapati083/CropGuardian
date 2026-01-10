import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = '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';

  Future<String> analyzeCrop({
    required String imageUrl,
    required String description,
    required String language,
  }) async {
    final uri =
    Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final prompt = '''
You are an agriculture expert.
Analyze the crop disease from the image.

Language: $language
Farmer description: $description

Give:
1. Disease name
2. Symptoms
3. Cause
4. Treatment
5. Prevention
''';

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://cropguardian.app',
        'X-Title': 'CropGuardian',
      },
      body: jsonEncode({
        "model": "google/gemini-1.5-flash:free",
        "messages": [
          {
            "role": "user",
            "content": [
              {"type": "text", "text": prompt},
              {
                "type": "image_url",
                "image_url": {"url": imageUrl}
              }
            ]
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data.toString());
    }

    return data['choices'][0]['message']['content'];
  }
}

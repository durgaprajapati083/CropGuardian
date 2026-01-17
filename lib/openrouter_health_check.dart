import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('🔍 Starting OpenRouter Health Check...');
  await OpenRouterHealthCheck.test();
}

class OpenRouterHealthCheck {
  static const String apiKey =
      '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';

  static const String apiUrl =
      'https://openrouter.ai/api/v1/chat/completions';

  static const String model =
      'qwen/qwen-2-vl-7b-instruct:free';

  static Future<void> test() async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
      'HTTP-Referer': 'https://yourapp.com', // REQUIRED by OpenRouter
      'X-Title': 'CropGuardian',             // REQUIRED by OpenRouter
    };

    final body = {
      "model": model,
      "messages": [
        {
          "role": "user",
          "content": "Reply with the word OK only."
        }
      ],
      "max_tokens": 5,
      "temperature": 0.0
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      print('Status Code: ${response.statusCode}');
      print('Raw Response: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      if (decoded['choices'] == null ||
          decoded['choices'].isEmpty ||
          decoded['choices'][0]['message'] == null ||
          decoded['choices'][0]['message']['content'] == null) {
        throw Exception('No usable response from OpenRouter');
      }

      final content =
      decoded['choices'][0]['message']['content'];

      print('✅ OpenRouter WORKING');
      print('Model Response: $content');
    } catch (e) {
      print('❌ OpenRouter FAILED');
      print('Reason: $e');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/diagnosis_model.dart';

class OpenRouterService {
  DateTime? _lastRequestTime;
  static const int _minDelaySeconds = 3;

  Future<String> analyzeImage(String imageUrl, String? userDescription) async {
    try {
      await _enforceRateLimit();

      final prompt = _buildPrompt(userDescription);

      print('Sending request to OpenRouter...');
      print('Using model: ${AppConstants.visionModel}');

      final response = await http.post(
        Uri.parse(AppConstants.openRouterApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.openRouterApiKey}',
          'HTTP-Referer': 'https://cropguardian.app',
          'X-Title': 'CropGuardian',
        },
        body: jsonEncode({
          'model': AppConstants.visionModel,
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': prompt,
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': imageUrl,
                  },
                },
              ],
            },
          ],
          'max_tokens': 2000,
          'temperature': 0.7,
        }),
      );

      _lastRequestTime = DateTime.now();

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['choices'] != null && data['choices'].isNotEmpty) {
          final text = data['choices'][0]['message']['content'];
          print('Response received successfully');
          return text;
        } else {
          throw Exception('No response from OpenRouter');
        }
      } else {
        final errorBody = response.body;
        print('Error response: $errorBody');
        if (response.statusCode == 503) {
          throw Exception(
              'AI service is temporarily unavailable. Please try again later.'
          );
        }

        throw Exception('API error: ${response.statusCode}');
      }
    } catch (e) {
      print('OpenRouter error: $e');

      if (e.toString().contains('quota') || e.toString().contains('rate')) {
        throw Exception('API limit reached. Please wait and try again.');
      }

      throw Exception('Failed to analyze: $e');
    }
  }

  Future<void> _enforceRateLimit() async {
    if (_lastRequestTime != null) {
      final timeSinceLastRequest = DateTime.now().difference(_lastRequestTime!);
      if (timeSinceLastRequest.inSeconds < _minDelaySeconds) {
        final waitTime = _minDelaySeconds - timeSinceLastRequest.inSeconds;
        print('Waiting $waitTime seconds...');
        await Future.delayed(Duration(seconds: waitTime));
      }
    }
  }

  String _buildPrompt(String? userDescription) {
    String prompt = '''
Analyze this crop/plant image and provide diagnosis in JSON format:

{
  "cropType": "crop name",
  "detectedIssue": "disease/pest or Healthy",
  "severity": "Low/Medium/High/Critical",
  "symptoms": ["symptom1", "symptom2"],
  "description": "detailed description",
  "solutions": ["solution1", "solution2"],
  "recommendedPesticides": [
    "Pesticide name (active ingredient – dosage – application method)",
    "Alternative pesticide if available"
  ],
  "preventiveMeasures": ["measure1", "measure2"]
}
''';

    if (userDescription != null && userDescription.isNotEmpty) {
      prompt += '\n\nUser notes: $userDescription\n';
    }

    prompt += '\n\nProvide practical farming advice. Return ONLY valid JSON.';
    return prompt;
  }

  DiagnosisModel parseDiagnosisResponse(String responseText) {
    try {
      String cleanText = responseText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(cleanText);
      if (jsonMatch != null) {
        final jsonString = jsonMatch.group(0)!;
        final json = jsonDecode(jsonString);
        return DiagnosisModel.fromJson(json);
      }
      throw Exception('No valid JSON found');
    } catch (e) {
      throw Exception('Parse error: $e');
    }
  }
}
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

      // 1. USE THE CONSTANT from AppConstants instead of a hardcoded string
      // 2. STABLE MODEL RECOMMENDATION: 'google/gemini-flash-1.5' or 'google/gemini-2.0-flash-001'
      final response = await http.post(
        Uri.parse(AppConstants.openRouterApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.openRouterApiKey}',
          'HTTP-Referer': 'https://cropguardian.app',
          'X-Title': 'CropGuardian',
        },
        body: jsonEncode({
          // Change this to a stable model ID
          'model': 'google/gemini-2.0-flash-001',
          'messages': [
            {
              'role': 'user',
              'content': [
                {'type': 'text', 'text': prompt},
                {
                  'type': 'image_url',
                  'image_url': {'url': imageUrl} // Your Cloudinary URL
                },
              ],
            },
          ],
        }),
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'].toString();
        }
        throw Exception('AI returned an empty message.');
      } else {
        // This will print the exact reason from OpenRouter (e.g., "Model not found")
        print('Detailed Error Body: ${response.body}');
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('OpenRouter Error: $e');
      rethrow;
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
  "confidence_score":0.95,
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
        final Map<String,dynamic> json = jsonDecode(jsonString);
        if(!json.containsKey('confidence_score')){
          json['confidence_score']=0.85;
        }
        json['timestamp']=DateTime.now().toIso8601String();
        // final json = jsonDecode(jsonString);
        return DiagnosisModel.fromJson(json);
      }
      throw Exception('No valid JSON found');
    } catch (e) {
      throw Exception('Parse error: $e');
    }
  }
}
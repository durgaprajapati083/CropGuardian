import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DiagnosisService {
  static const String _apiKey = "AIzaSyAdDbL7X2jdEXBCrlQ3fFfmSpeAJD7tn7s";

  static Future<String> diagnoseCrop({
    required File imageFile,
    required String description,
    required String language,
  }) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final uri = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey",
    );

    final prompt = """
You are an agricultural expert.

Analyze the given crop image.
Farmer description: "$description"
Respond strictly in $language.

Give:
1. Disease name
2. Symptoms
3. Causes
4. Treatment
5. Prevention tips
""";

    final body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt},
            {
              "inlineData": {
                "mimeType": "image/jpeg",
                "data": base64Image
              }
            }
          ]
        }
      ]
    };

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final data = jsonDecode(response.body);
    return data["candidates"][0]["content"]["parts"][0]["text"];
  }
}

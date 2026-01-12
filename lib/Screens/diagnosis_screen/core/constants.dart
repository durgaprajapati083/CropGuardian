class AppConstants {
  // Cloudinary Configuration
  static const String cloudinaryCloudName = 'dbsesnq44';
  static const String cloudinaryUploadPreset = 'crop_images';

  // OpenRouter API Configuration (FREE - supports vision models)
  static const String openRouterApiKey = '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';
  static const String openRouterApiUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const String visionModel = 'qwen/qwen-2-vl-7b-instruct:free';


//   // Option 1 (Best for crops):
//   static const String visionModel = 'meta-llama/llama-3.2-90b-vision-instruct:free';
//
// // Option 2 (Smaller, faster):
//   static const String visionModel = 'meta-llama/llama-3.2-11b-vision-instruct:free';
//
// // Option 3 (Alternative):
//   static const String visionModel = 'qwen/qwen-2-vl-7b-instruct:free';

  // Supported Languages
  static const List<String> supportedLanguages = [
    'English',
    'Hindi',
    'Kannada'
  ];

  // Language Codes for Translation
  static const Map<String, String> languageCodes = {
    'English': 'en',
    'Hindi': 'hi',
    'Kannada': 'kn',
  };

  // Text-to-Speech Language Codes
  static const Map<String, String> ttsLanguageCodes = {
    'English': 'en-US',
    'Hindi': 'hi-IN',
    'Kannada': 'kn-IN',
  };

  // App Theme Colors
  static const int primaryGreen = 0xFF4CAF50;
  static const int lightGreen = 0xFF81C784;
  static const int darkGreen = 0xFF388E3C;

  // App Configuration
  static const String appName = 'CropGuardian';
  static const String appVersion = '1.0.0';

  // API Timeouts
  static const int apiTimeout = 30;
  static const int uploadTimeout = 60;
}
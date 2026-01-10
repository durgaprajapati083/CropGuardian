import 'dart:io';
import 'package:croupguardiandurgaprajapati/Screens/diagnosis_screen/services/cloudinary_service.dart';
import 'package:croupguardiandurgaprajapati/Screens/diagnosis_screen/services/tts_service.dart';
import 'package:croupguardiandurgaprajapati/Screens/diagnosis_screen/viewmodels/diagnosis_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';


class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final TextEditingController _descController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _language = 'English';

  final ImagePicker _picker = ImagePicker();

  /// PICK IMAGE + UPLOAD
  Future<void> _pickImage(BuildContext context) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final file = File(picked.path);

    // Upload to Cloudinary
    final imageUrl = await CloudinaryService.uploadImage(file);

    context.read<DiagnosisViewModel>().setImage(file, imageUrl);
  }

  //Voice Method
  Future<void> _listenVoice() async {
    if (!_isListening) {
      final available = await _speech.initialize();
      if (!available) return;

      setState(() => _isListening = true);

      await _speech.listen(
        localeId: _language == 'Hindi'
            ? 'hi_IN'
            : _language == 'Kannada'
            ? 'kn_IN'
            : 'en_IN',
        onResult: (result) {
          _descController.text = result.recognizedWords;
        },
      );
    } else {
      await _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DiagnosisViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('CropGuardian')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE UPLOAD BOX
            GestureDetector(
              onTap: () => _pickImage(context),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: vm.imageFile == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.upload, size: 40, color: Colors.green),
                    SizedBox(height: 8),
                    Text('Tap to upload crop image'),
                    Text('PNG / JPG (max 5MB)',
                        style: TextStyle(color: Colors.grey)),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    vm.imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION FIELD
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describe crop issue (optional)',
                border: OutlineInputBorder(),
              ),
            ),

            // Mic Button
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.green,
                ),
                onPressed: _listenVoice,
              ),
            ),

            const SizedBox(height: 16),

            /// LANGUAGE SELECTOR
            Row(
              children: [
                _languageButton('English'),
                const SizedBox(width: 8),
                _languageButton('Hindi'),
                const SizedBox(width: 8),
                _languageButton('Kannada'),
              ],
            ),

            const SizedBox(height: 20),

            /// DIAGNOSE BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: vm.isLoading || vm.uploadedImageUrl == null
                    ? null
                    : () {
                  vm.diagnoseCrop(
                    imageUrl: vm.uploadedImageUrl!,
                    description: _descController.text,
                    language: _language,
                  );
                },
                child: vm.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Diagnose Crop'),
              ),
            ),

            const SizedBox(height: 24),

            /// RESULT
            if (vm.result.isNotEmpty)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(vm.result),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.volume_up, color: Colors.green),
              onPressed: () {
                TtsService.speak(vm.result, _language);
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _languageButton(String lang) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          _language == lang ? Colors.green : Colors.grey[300],
          foregroundColor:
          _language == lang ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() => _language = lang);
        },
        child: Text(lang),
      ),
    );
  }
}

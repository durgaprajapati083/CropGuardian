import 'package:croupguardiandurgaprajapati/Screens/diagnosis_screen/viewmodels/diagnosis_viewmodel.dart';
import 'package:croupguardiandurgaprajapati/Screens/diagnosis_screen/widgets/image_picker_card.dart';
import 'package:croupguardiandurgaprajapati/Screens/diagnosis_screen/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/diagnosis_model.dart';


class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiagnosisViewModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
         iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              children: [
                const Text(
                  "AI Crop Diagnose",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text("एआई-फसल निदान", style: TextStyle(color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // backgroundColor: Color(0xFF388E3C),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Consumer<DiagnosisViewModel>(
                  builder: (context, viewModel, child) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image Picker Card
                          ImagePickerCard(
                            selectedImage: viewModel.selectedImage,
                            onImageSelected: (image) => viewModel.setImage(image),
                          ),
          
                          // Description Input
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: 'Describe crop issue (optional)',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(16),
                                      ),
                                      maxLines: 3,
                                      onChanged: (value) => viewModel.setDescription(value),
                                    ),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(
                                  //     viewModel.isListening ? Icons.mic : Icons.mic_none,
                                  //     color: viewModel.isListening ? Colors.red : Colors.grey,
                                  //   ),
                                  //   onPressed: () => viewModel.toggleVoiceInput(),
                                  // ),
                                ],
                              ),
                            ),
                          ),
          
                          // Language Selector
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: LanguageSelector(
                              selectedLanguage: viewModel.selectedLanguage,
                              onLanguageChanged: (lang) => viewModel.setLanguage(lang),
                            ),
                          ),
          
                          const SizedBox(height: 16),
          
                          // Diagnose Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              onPressed: viewModel.isLoading ? null : () => viewModel.performDiagnosis(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[900],
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: viewModel.isLoading
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                'Diagnose Crop',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
          
                          // Error Message
                          if (viewModel.errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.red.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red.shade700),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        viewModel.errorMessage,
                                        style: TextStyle(color: Colors.red.shade700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
          
                          // Diagnosis Result
                          if (viewModel.diagnosis != null)
                            _buildDiagnosisResult(context, viewModel.diagnosis!, viewModel),
          
                          const SizedBox(height: 24),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiagnosisResult(
      BuildContext context,
      DiagnosisModel diagnosis,
      DiagnosisViewModel viewModel,
      ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with TTS control
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Diagnosis Result',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      viewModel.isSpeaking ? Icons.stop_circle : Icons.volume_up,
                      color: Colors.green,
                    ),
                    onPressed: () => viewModel.toggleSpeech(),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Crop Type
                  _buildInfoRow(Icons.agriculture, 'Crop Type', diagnosis.cropType),
                  const Divider(),

                  // Detected Issue
                  _buildInfoRow(Icons.warning_amber, 'Issue', diagnosis.detectedIssue),
                  const Divider(),

                  // Severity
                  _buildSeverityRow(diagnosis.severity),
                  const Divider(),

                  // confidenceScore
                  _buildConfidenceRow(diagnosis.confidenceScore),
                  const Divider(),

                  // Description
                  const SizedBox(height: 12),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    diagnosis.description,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),

                  // Symptoms
                  if (diagnosis.symptoms.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Symptoms',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...diagnosis.symptoms.map(
                          (symptom) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontSize: 16)),
                            Expanded(child: Text(symptom)),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Solutions
                  if (diagnosis.solutions.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Solutions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...diagnosis.solutions.asMap().entries.map(
                          (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '${entry.key + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(entry.value)),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Preventive Measures
                  if (diagnosis.preventiveMeasures.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Preventive Measures',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...diagnosis.preventiveMeasures.map(
                          (measure) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(child: Text(measure)),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Pesticide Measures
                  if (diagnosis.recommendedPesticides.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Pesticide',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...diagnosis.recommendedPesticides.map(
                          (measure) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle,
                                size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(child: Text(measure)),
                          ],

                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSeverityRow(String severity) {
    Color severityColor;
    switch (severity.toLowerCase()) {
      case 'low':
        severityColor = Colors.green;
        break;
      case 'medium':
        severityColor = Colors.orange;
        break;
      case 'high':
      case 'critical':
        severityColor = Colors.red;
        break;
      default:
        severityColor = Colors.grey;
    }

    return Row(
      children: [
        Icon(Icons.priority_high, color: severityColor, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Severity',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: severityColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                severity,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: severityColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildConfidenceRow(double confidence) {
  // Convert 0.95 to 95%
  int percentage = (confidence * 100).toInt();

  // Color logic: Green for high confidence, Orange for medium
  Color scoreColor = percentage >= 80 ? Colors.blue.shade700 : Colors.orange.shade700;

  return Row(
    children: [
      Icon(Icons.verified_user_rounded, color: scoreColor, size: 24),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Confidence',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: scoreColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scoreColor.withOpacity(0.3)),
            ),
            child: Text(
              "$percentage%",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: scoreColor,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
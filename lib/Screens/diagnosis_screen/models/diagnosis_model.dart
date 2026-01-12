class DiagnosisModel {
  final String cropType;
  final String detectedIssue;
  final String severity;
  final List<String> symptoms;
  final String description;
  final List<String> solutions;
  final List<String> preventiveMeasures;
  final List<String> recommendedPesticides;

  final String timestamp;

  DiagnosisModel({
    required this.cropType,
    required this.detectedIssue,
    required this.severity,
    required this.symptoms,
    required this.description,
    required this.solutions,
    required this.preventiveMeasures,
    required this.recommendedPesticides,

    required this.timestamp,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      cropType: json['cropType'] ?? 'Unknown',
      detectedIssue: json['detectedIssue'] ?? 'No issue detected',
      severity: json['severity'] ?? 'Unknown',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      description: json['description'] ?? '',
      solutions: List<String>.from(json['solutions'] ?? []),
      preventiveMeasures: List<String>.from(json['preventiveMeasures'] ?? []),
      recommendedPesticides:
      List<String>.from(json['recommendedPesticides'] ?? []),
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cropType': cropType,
      'detectedIssue': detectedIssue,
      'severity': severity,
      'symptoms': symptoms,
      'description': description,
      'solutions': solutions,
      'preventiveMeasures': preventiveMeasures,
      'recommendedPesticides': recommendedPesticides,
      'timestamp': timestamp,
    };
  }
}
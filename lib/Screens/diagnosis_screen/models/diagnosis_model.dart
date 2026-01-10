class DiagnosisModel {
  final String imageUrl;
  final String diagnosis;
  final String language;
  final DateTime createdAt;

  DiagnosisModel({
    required this.imageUrl,
    required this.diagnosis,
    required this.language,
    required this.createdAt,
  });
}

class FarmerProfileModel {
  final String userId;
  final String userName; // Read-only from Firestore
  final String userPhone; // Read-only from Firestore
  final String userEmail; // Read-only from Firestore
  String? location;
  String? language;
  String? farmSize;
  String? cropsGrown;
  String? profileImageUrl;

  FarmerProfileModel({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    this.location,
    this.language,
    this.farmSize,
    this.cropsGrown,
    this.profileImageUrl,
  });

  factory FarmerProfileModel.fromMap(Map<String, dynamic> data, String id) {
    return FarmerProfileModel(
      userId: id,
      userName: data['userName'] ?? '',
      userPhone: data['userPhone'] ?? '',
      userEmail: data['userEmail'] ?? '',
      location: data['location'] ?? '',
      language: data['language'] ?? 'English',
      farmSize: data['farmSize'] ?? '',
      cropsGrown: data['cropsGrown'] ?? '',
      profileImageUrl: data['profileImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'userId': userId,
      'location': location,
      'language': language,
      'farmSize': farmSize,
      'cropsGrown': cropsGrown,
      'profileImageUrl': profileImageUrl,
    };
  }
}
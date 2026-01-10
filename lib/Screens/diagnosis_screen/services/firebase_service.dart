import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> saveDiagnosis({
    required String imageUrl,
    required String diagnosis,
    required String language,
  }) async {
    await _db.collection('diagnosis_history').add({
      'imageUrl': imageUrl,
      'diagnosis': diagnosis,
      'language': language,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

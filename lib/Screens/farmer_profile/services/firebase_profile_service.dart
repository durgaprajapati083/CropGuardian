import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/farmer_profile_model.dart';

class FirebaseProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FarmerProfileModel?> getUserProfile(String uid) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();
    if (doc.exists) {
      return FarmerProfileModel.fromMap(doc.data() as Map<String, dynamic>, uid);
    }
    return null;
  }

  Future<void> updateUserProfile(FarmerProfileModel profile) async {
    await _firestore.collection("users").doc(profile.userId).update(profile.toMap());
  }
}
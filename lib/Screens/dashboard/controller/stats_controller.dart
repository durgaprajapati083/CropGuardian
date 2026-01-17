import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Observable variables for real-time updates
  var diagnosesCount = 0.obs;
  var farmersCount = 0.obs;
  var accuracyValue = 85.0.obs; // You can calculate this from data

  @override
  void onInit() {
    super.onInit();
    _listenToStats();
  }

  void _listenToStats() {
    // Listen to total diagnoses
    _db.collection('diagnoses').snapshots().listen((snap) {
      diagnosesCount.value = snap.docs.length;
      if(snap.docs.isNotEmpty){
        double totalConfidence=0;
        for(var doc in snap.docs){
          totalConfidence +=(doc.data()['confidence'] ?? 0.85);
        }
        accuracyValue.value=(totalConfidence/snap.docs.length)*100;
      }
    });

    // Listen to total registered farmers
    _db.collection('users').snapshots().listen((snap) {
      farmersCount.value = snap.docs.length;
    });
  }
}
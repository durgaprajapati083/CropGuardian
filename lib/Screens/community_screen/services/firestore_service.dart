import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<PostModel>> getPosts() {
    return _db.collection('community_posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => PostModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addPost(Map<String, dynamic> data) => _db.collection('community_posts').add(data);
  Future<void> updatePost(String id, Map<String, dynamic> data) => _db.collection('community_posts').doc(id).update(data);
  Future<void> deletePost(String id) => _db.collection('community_posts').doc(id).delete();
}
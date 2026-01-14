import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../diagnosis_screen/services/cloudinary_service.dart';
import '../models/post_model.dart';

class CommunityController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var posts = <PostModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToPosts();
  }

  void _listenToPosts() {
    posts.bindStream(_db.collection("community_posts")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => PostModel.fromMap(doc.data(), doc.id)).toList()));
  }

  // --- IMAGE UPLOAD LOGIC (FIXES THE IMAGE NOT SHOWING) ---
  Future<String?> uploadToCloudinary(File file) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dbsesnq44/image/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'unsigned_profile_upload'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['secure_url']; // Returns the actual web URL
    }
    return null;
  }

  Future<void> submitPost(String content, File? imageFile) async {
    try {
      isLoading.value = true;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      // Add this line at the top of your CommunityController class
      final CloudinaryService _cloudinaryService = CloudinaryService();

      // 1. FETCH THE USER'S PROFILE TO GET THE IMAGE URL
      // Make sure 'users' matches your Firestore collection name
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      // Get the profile image URL from the user's document
      String? userProfilePic = userDoc.get('profileImageUrl');
      String userName = userDoc.get('userName') ?? "Farmer";

      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _cloudinaryService.uploadImage(imageFile);
      }

      // 2. SAVE EVERYTHING TO THE POST
      await FirebaseFirestore.instance.collection('community_posts').add({
        'userId': uid,
        'userName': userName,
        'userProfile': userProfilePic, // THIS IS THE KEY!
        'content': content,
        'imageUrl': imageUrl,
        'likedBy': [],
        'commentCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.back(); // Close bottom sheet
      Get.snackbar("Success", "Post uploaded successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    final res = await ImagePicker().pickImage(source: source, imageQuality: 60);
    return res != null ? File(res.path) : null;
  }

  void toggleLike(PostModel post) async {
    String uid = _auth.currentUser!.uid;
    DocumentReference ref = _db.collection("community_posts").doc(post.id);
    post.likedBy.contains(uid)
        ? await ref.update({'likedBy': FieldValue.arrayRemove([uid])})
        : await ref.update({'likedBy': FieldValue.arrayUnion([uid])});
  }


  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance.collection('community_posts').doc(postId).delete();
      Get.snackbar("Deleted", "Post removed successfully", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Could not delete post");
    }
  }

// Update a post
  Future<void> updatePost(String postId, String newContent) async {
    if (newContent.trim().isEmpty) return;
    try {
      await FirebaseFirestore.instance.collection('community_posts').doc(postId).update({
        'content': newContent,
        'updatedAt': FieldValue.serverTimestamp(), // Optional: track edits
      });
      Get.snackbar("Updated", "Post updated successfully", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Could not update post");
    }
  }





  Future<void> addComment(String postId, String text) async {
    if (text.trim().isEmpty) return;

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // 1. Fetch the user's latest profile to get the profileImageUrl
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users") // Ensure this matches your collection name
          .doc(uid)
          .get();

      String? userProfileUrl;
      if (userDoc.exists) {
        // Fetch the specific field name from your FarmerProfileModel
        userProfileUrl = userDoc.get('profileImageUrl');
      }

      // 2. Add the comment with the profile image URL
      await FirebaseFirestore.instance
          .collection("community_posts")
          .doc(postId)
          .collection("comments")
          .add({
        'userId': uid,
        'userName': userDoc.get('userName') ?? "Farmer",
        'userProfile': userProfileUrl, // This saves the Cloudinary URL in the comment
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. Update the comment count on the post
      await FirebaseFirestore.instance
          .collection("community_posts")
          .doc(postId)
          .update({'commentCount': FieldValue.increment(1)});

    } catch (e) {
      print("Comment Error: $e");
    }
  }
}
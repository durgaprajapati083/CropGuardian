import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String? userProfile;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final List<String> likedBy;
  final int commentCount;

  PostModel({
    required this.id, required this.userId, required this.userName,
    this.userProfile, required this.content, this.imageUrl,
    required this.createdAt, required this.likedBy, required this.commentCount,
  });

  factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
    return PostModel(
      id: docId,
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? 'Farmer',
      userProfile: map['userProfile'],
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'],
      commentCount: (map['commentCount'] ?? 0) as int,
      likedBy: map['likedBy'] != null ? List<String>.from(map['likedBy']) : [],
      createdAt: (map['createdAt'] is Timestamp)
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId, 'userName': userName, 'userProfile': userProfile,
      'content': content, 'imageUrl': imageUrl, 'createdAt': createdAt,
      'likedBy': likedBy, 'commentCount': commentCount,
    };
  }
}
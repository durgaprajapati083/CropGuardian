import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  // TODO: REPLACE WITH YOUR CLOUDINARY DETAILS
  static const String _cloudName = 'dbsesnq44';
  static const String _uploadPreset = 'unsigned_profile_upload';

  final CloudinaryPublic cloudinary = CloudinaryPublic(_cloudName, _uploadPreset, cache: false);

  Future<String?> uploadImage(File imageFile) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imageFile.path, resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } catch (e) {
      print("Cloudinary Upload Error: $e");
      throw Exception("Failed to upload image");
    }
  }
}
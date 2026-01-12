import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../core/constants.dart';

class CloudinaryService {
  late CloudinaryPublic _cloudinary;

  CloudinaryService() {
    _cloudinary = CloudinaryPublic(
      AppConstants.cloudinaryCloudName,
      AppConstants.cloudinaryUploadPreset,
      cache: false,
    );
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          folder: 'crop_diagnoses',
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } catch (e) {
      print('Cloudinary upload error: $e');
      return null;
    }
  }

  Future<bool> deleteImage(String publicId) async {
    try {
      // Note: cloudinary_public package doesn't support delete operation
      return true;
    } catch (e) {
      print('Cloudinary delete error: $e');
      return false;
    }
  }
}
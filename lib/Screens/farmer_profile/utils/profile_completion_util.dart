import '../model/farmer_profile_model.dart';

class ProfileCompletionUtil {
  static double calculate(FarmerProfileModel profile) {
    int totalFields = 7;
    int filled = 0;
    if (profile.userName.isNotEmpty) filled++;
    if (profile.userPhone.isNotEmpty) filled++;
    if (profile.location?.isNotEmpty ?? false) filled++;
    if (profile.language?.isNotEmpty ?? false) filled++;
    if (profile.farmSize?.isNotEmpty ?? false) filled++;
    if (profile.cropsGrown?.isNotEmpty ?? false) filled++;
    if (profile.profileImageUrl?.isNotEmpty ?? false) filled++;
    return filled / totalFields;
  }
}
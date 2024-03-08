// profile_controller.dart
import '../models/api_response_model.dart';
import '../models/user_profile_model.dart';
import '../services/auth_service.dart';

class ProfileController {
  Future<UserData?> fetchProfileData() async {
    ApiResponse apiResponse = await getProfile();

    if (apiResponse.error != null) {
      return null;
    } else {
      return apiResponse.data as UserData?;
    }
  }

  Future<void> fetchAndSetProfileData(
      Function(UserData? profile, bool isLoading) callback) async {
    callback(null, true);

    UserData? profile = await fetchProfileData();
    callback(profile, false);
  }
}
//update profile metodos


  
// profile_controller.dart
import 'package:vtschool/src/models/api_response_model.dart';
import 'package:vtschool/src/models/user_profile_model.dart';
import 'package:vtschool/src/services/auth_service.dart';




class ProfileController {

   final AuthService authProvider = AuthService();
  Future<UserData?> fetchProfileData() async {
    ApiResponse apiResponse = await authProvider.getProfile();

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


  
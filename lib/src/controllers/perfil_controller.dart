// profile_controller.dart
/*import 'package:vtschool/src/models/api_response_model.dart';
import 'package:vtschool/src/models/user_profile_model.dart';
import 'package:vtschool/src/providers/auth_provider.dart';




class ProfileController {

   final AuthProvider authProvider = AuthProvider();
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



  */
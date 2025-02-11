import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class UpdatePasswordController extends GetxController {
  //final TextEditingController email = TextEditingController();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final recoverPasswordController = TextEditingController();
  var isCurrentPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isRecoverPasswordVisible = false.obs;
  var sendPassword = false.obs;
  final AuthProvider authProvider = AuthProvider();
  

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleRecoverPasswordVisibility() {
    isRecoverPasswordVisible.value = !isRecoverPasswordVisible.value;
  }

 Future<void> changePassword() async {
  try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String rolUser = await authProvider.getRolUser();
      String? idUser = prefs.getString('idUser');
      String? idUserGuardian = prefs.getString('idUserGuardian');
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        recoverPasswordController.text.isEmpty) {
        Get.snackbar("Error", "Todos los campos son obligatorios");
      return;
    }

    if(newPasswordController.text.length < 8) {
      Get.snackbar("Error", "La contraseña debe tener por lo menos 8 caracteres");
      return;
    }

    if (newPasswordController.text != recoverPasswordController.text) {
      Get.snackbar("Error", "Las contraseñas no coinciden");
      return;
    } 

    if(rolUser == 'ACUDIENTE'){
         sendPassword.value = true;
        await authProvider.updatePassword(idUserGuardian!, recoverPasswordController.text, currentPasswordController.text); 
      }else{
        sendPassword.value = true;
        await authProvider.updatePassword(idUser!, recoverPasswordController.text, currentPasswordController.text); 
      }
  } catch (e) {
    Get.snackbar("Error", "$e");
  }
}


  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    recoverPasswordController.dispose();
    super.onClose();
  }
}

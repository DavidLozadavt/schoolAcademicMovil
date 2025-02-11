import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class RecoverPasswordController extends GetxController {

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final recoverPasswordController = TextEditingController();
  var isNewPasswordVisible = false.obs;
  var isRecoverPasswordVisible = false.obs;
  var sendEmailIsLoading = false.obs;
  var sendOtpIsLoading = false.obs;
  var sendPasswordOtpIsLoading = false.obs;
  final AuthProvider authProvider = AuthProvider();

   Future<void> sendOtp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Escribe un email");
      return;
    }
    const emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final isEmailValid = RegExp(emailPattern).hasMatch(emailController.text);

    if (!isEmailValid) {
      Get.snackbar("Error", "Escribe un email válido");
      return;
    }
    sendEmailIsLoading.value = true;
    await pref.setString('emailOtp', emailController.text);
    await authProvider.sendOtp(emailController.text);
  } catch (e) {
    Get.snackbar("Error", "$e");
  }
}

  Future<void> validateOtp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
   String? savedEmailOto = await pref.getString('emailOtp');
  try {
    if (otpController.text.isEmpty) {
      Get.snackbar("Error", "Escribe tu código");
      return;
    }
    sendOtpIsLoading.value = true;
    await pref.setString('otp', otpController.text);
    await authProvider.validateOtp(savedEmailOto!, otpController.text);
  
  } catch (e) {
    Get.snackbar("Error", "$e");
  }
  }

   Future<void> resetPasswordByOtp() async {
   SharedPreferences pref = await SharedPreferences.getInstance();
   String? savedEmailOto = await pref.getString('emailOtp');
  String? savedOtp = await pref.getString('otp');
  try {
     if (
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
    sendPasswordOtpIsLoading.value = true;
    await authProvider.resetPasswordByOtp(savedEmailOto!, savedOtp!, recoverPasswordController.text);
  } catch (e) {
    Get.snackbar("Error", "$e");
  }
  }

   void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleRecoverPasswordVisibility() {
    isRecoverPasswordVisible.value = !isRecoverPasswordVisible.value;
  }

  Future<void> clearAllPreferences() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('emailOtp');
  await pref.remove('otp');
}
}
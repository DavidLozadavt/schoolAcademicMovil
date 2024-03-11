import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vtschool/src/models/auth_user_model.dart';
import 'package:vtschool/src/services/auth_service.dart';
import 'package:vtschool/src/errors/failure.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService authProvider = AuthService();
  var passwordVisible = false.obs;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  goToRegisterPage() {
    Get.toNamed('/register');
  }

  goToHomePageStudent() {
    Get.offAllNamed('/home_student');
  }

  goToHomePageTeacher() {
    Get.offAllNamed('/home_teacher');
  }

  login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar(
          'Error!',
          'Por favor completa todos los campos!',
        );
        return;
      }
      final UserData responseApiLogin = await authProvider.login(
        emailController.text,
        passwordController.text,
      );

      await pref.setString('token', responseApiLogin.accessToken);
      await pref.setString('email', emailController.text);
      await pref.setString('rolUser', responseApiLogin.payload.roles[0]);
      
      //await pref.setString('contrasena', passwordController.text);
      if (responseApiLogin.payload.roles[0] == 'ADMIN') {
        goToHomePageTeacher();
      } else if (responseApiLogin.payload.roles[0] == 'ESTUDIANTE') {
        goToHomePageStudent();
      }
    } on Failure catch (e) {
      Get.snackbar(
        'Error!',
        '${e.message}!',
      );
    }
  }

  Future<void> loadEmailFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedEmail = prefs.getString('email') ?? '';
    emailController.text = savedEmail;
  }
}

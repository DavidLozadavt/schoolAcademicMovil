import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vtschool/src/models/auth_user_model.dart';
import 'package:vtschool/src/providers/auth_provider.dart';
import 'package:vtschool/src/errors/failure.dart';
//import 'package:vtschool/src/screens/profile/profile_user_controller.dart';

class LoginController extends GetxController {
  //  final ProfileUserController _profileController =
  //     Get.put(ProfileUserController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthProvider authProvider = AuthProvider();
  var passwordVisible = false.obs;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  goToHomePageStudent() {
    //Get.find<ProfileUserController>().fetchEvents();
    // _profileController.fetchEvents();
    Get.offAllNamed('/home_student');
  }

  goToHomePageTeacher() {
    Get.offAllNamed('/home_teacher');
  }

  goToHomePageAdmin() {
    Get.offAllNamed('/home_admin');
  }

 login() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? tokenDevice = pref.getString('token_device') ?? '';
  try {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        '¡Error!',
        '¡Por favor completa todos los campos!',
      );
      return;
    }

    final UserData responseApiLogin = await authProvider.login(
        emailController.text, passwordController.text, tokenDevice);

    String rolUsuario = responseApiLogin.payload.roles[0];
    if (rolUsuario == 'ADMIN') {
      Get.snackbar(
        '¡Hola!',
        '¡Estamos trabajando para mejorar, pronto tendremos acceso para el administrador!',
      );
      //goToHomePageAdmin();
    } else if (rolUsuario == 'ESTUDIANTE') {
      await pref.setString('token', responseApiLogin.accessToken);
      await pref.setString('email', emailController.text);
      await pref.setString('rolUser', rolUsuario);
      await pref.setString('idUser', responseApiLogin.user.id.toString());
      await pref.setInt('tokenExpiresIn', responseApiLogin.expiresIn);
      Future.delayed(const Duration(seconds: 1), () {
        goToHomePageStudent();
        Get.snackbar('¡Hola!', 'Un gusto tenerte de nuevo');
      });
    } else if (rolUsuario == 'DOCENTE') {
      await pref.setString('token', responseApiLogin.accessToken);
      await pref.setString('email', emailController.text);
      await pref.setString('rolUser', rolUsuario);
      await pref.setString('idUser', responseApiLogin.user.id.toString());
      await pref.setInt('tokenExpiresIn', responseApiLogin.expiresIn);
      await pref.setString('idContrato',
          responseApiLogin.user.persona.contrato!.id.toString());
      Future.delayed(const Duration(seconds: 1), () {
        goToHomePageTeacher();
        Get.snackbar('¡Hola!', 'Un gusto tenerte de nuevo');
      });
    } else if (rolUsuario == 'ESTUDIANTEUP') {
      // Guardar token y otros datos si es necesario
      await pref.setString('token', responseApiLogin.accessToken);
      await pref.setString('email', emailController.text);
      await pref.setString('rolUser', rolUsuario);
      await pref.setString('idUser', responseApiLogin.user.id.toString());
      await pref.setInt('tokenExpiresIn', responseApiLogin.expiresIn);

      // Redirigir a la página para completar los datos
      Get.offAllNamed('/complete_student_data');
      Get.snackbar('¡Bienvenido!', 'Por favor, completa tus datos.');
    }
  } on Failure catch (e) {
    Get.snackbar(
      '¡Error!',
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

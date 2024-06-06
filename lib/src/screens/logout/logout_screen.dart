// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/auth_provider.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';

Future<void> logoutApp(BuildContext context) async {
  final AuthProvider authProvider = AuthProvider();
  authProvider.logout();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/intento.gif",
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            const Text(
              "Cerrando sesión...",
              style: kTlightpro,
            ),
          ],
        ),
      );
    },
  );

  //await Future.delayed(const Duration(seconds: 1));
  SharedPreferences pref = await SharedPreferences.getInstance();
  Get.offAllNamed('/login');
  await pref.remove('token');
  await pref.remove('rolUser');
  await pref.remove('idUser');
  await pref.remove('urlLogoCompany');
  Get.find<ProfileUserController>().clearUserData();
  
}

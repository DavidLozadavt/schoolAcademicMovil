// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/services/auth_service.dart';

Future<void> logoutApp(BuildContext context) async {
  final AuthService authProvider = AuthService();
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
              "assets/animations/logo-3.gif",
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

  await Future.delayed(const Duration(seconds: 1));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('rolUser');

  Get.offAllNamed('/login');
}

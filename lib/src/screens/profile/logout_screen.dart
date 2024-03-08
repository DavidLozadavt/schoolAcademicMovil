// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:vtschool/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logoutApp(BuildContext context) async {
  logout();
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
  //final token = GetStorage().read('token');
  //print('${token} aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  GetStorage().remove('token');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');

  Get.back();

  Get.offAllNamed(
      '/login'); // o Get.toNamed('/login') dependiendo de tus necesidades
}

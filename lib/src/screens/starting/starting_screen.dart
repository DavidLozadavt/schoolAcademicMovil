import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/starting/global_controller.dart';


class StartingPage extends StatelessWidget {
  StartingPage({super.key});

  final GlobalController controller =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/animations/logo-3.gif',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
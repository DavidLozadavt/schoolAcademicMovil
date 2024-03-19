import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/starting/global_controller.dart';

class StartingInitScreen extends StatelessWidget {
  StartingInitScreen({super.key});

  final GlobalController controller =
      Get.put(GlobalController(), permanent: true);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          scale: 1.5,
          width: 10,
        ),
      ),
    );
  }
}

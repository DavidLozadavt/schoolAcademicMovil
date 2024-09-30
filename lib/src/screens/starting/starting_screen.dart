import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/starting/global_controller.dart';

class StartingInitScreen extends StatelessWidget {
  StartingInitScreen({super.key});

  final GlobalController controller =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/intento.gif',
            scale: 1.5,
            width: 50,
          ),
        ),
      ),
    );
  }
}

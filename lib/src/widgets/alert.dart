import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AlertGeneric extends GetxController {

   Future<AlertDialog> alertGeneric(String title, String message) async {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      ],
    );
  }


}

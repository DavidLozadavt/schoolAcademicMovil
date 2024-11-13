import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/support_provider.dart';

class SupportController extends GetxController {

   TextEditingController comment = TextEditingController();
   RxString selectedFilePath = ''.obs;
   Rx<File> filePath = Rx<File>(File(''));
    final SupportProvider _supportProvider = SupportProvider();

Future<void> sendSupport() async {
    try {
      if (comment.text.isEmpty) {
        Get.snackbar(
          '¡Error!',
          'Debes escribir una descripción',
        );
        return;
      }

      if (comment.text.isNotEmpty &&
            filePath.value.path.isNotEmpty) {
          await _supportProvider.sendSupport(
              comment.text, filePath.value);
        } else if (filePath.value.path.isEmpty) {
           await _supportProvider.sendSupport(
              comment.text, null);
      }
    } on Failure catch (e) {
      Get.snackbar(
        '¡Error!',
        '${e.message}!',
      );
    }
  }

   void setSelectedFilePath(String path) {
    selectedFilePath.value = path;
  }

  void setFilePath(File path) {
    filePath.value = path;
  }


}

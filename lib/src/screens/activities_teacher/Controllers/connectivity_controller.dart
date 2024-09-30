import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = (result != ConnectivityResult.none);
      if (!isConnected.value) {
        showAlert();
      }
    } as void Function(List<ConnectivityResult> event)?);
  }

  void showAlert() {
    Get.defaultDialog(
      title: 'Sin Conexión',
      middleText: 'No estás conectado a Internet.',
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Aceptar'),
      ),
    );
  }
}

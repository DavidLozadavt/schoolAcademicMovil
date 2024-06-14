import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogWidget {
  final String paymentRoute;
  final String transactionRoute;
  final String tittle;

  CustomDialogWidget(
      {required this.paymentRoute,
      required this.transactionRoute,
      required this.tittle});

  void showDialog() {
    Get.defaultDialog(
      title: tittle,
      middleText: 'Selecciona una acción',
      middleTextStyle: const TextStyle(fontSize: 16),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
            //Get.toNamed(paymentRoute);
            Get.snackbar('¡Informacion!', 'Estamos trabajando para mejorar, pronto tendremos pagos físicos');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Pago físico'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.toNamed(transactionRoute);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Transacción'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

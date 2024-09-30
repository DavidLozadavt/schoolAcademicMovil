import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import 'package:vtschool/src/screens/payments/payments_controller.dart';

class PhysicalRegistrationPaymentScreen extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  PhysicalRegistrationPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 80,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Text(
                    'Pago inscripción',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => _paymentsController.isLoading1.value
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 25.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Comprobante de pago',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Card(
                              elevation: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles();
                                      if (result != null) {
                                        File file =
                                            File(result.files.single.path!);
                                        String filePath =
                                            result.files.single.path!;
                                        _paymentsController
                                            .setSelectedFilePath(filePath);
                                        _paymentsController.setFilePath(file);
                                      }
                                    },
                                    child: const Text('Seleccionar archivo'),
                                  ),
                                  const SizedBox(width: 5),
                                  Obx(() {
                                    if (_paymentsController
                                        .selectedFilePath.value.isNotEmpty) {
                                      String fileName = path.basename(
                                          _paymentsController
                                              .selectedFilePath.value);
                                      return Flexible(
                                        child: ElevatedButton(
                                          onPressed: null,
                                          child: Text(fileName),
                                        ),
                                      );
                                    } else {
                                      return const ElevatedButton(
                                        onPressed: null,
                                        child: Text('Archivo'),
                                      );
                                    }
                                  }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.network(
                                    _paymentsController.inscriptionPayments[0]
                                        ['configuracion_pago']['image'],
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _paymentsController
                                                .inscriptionPayments[0]
                                            ['configuracion_pago']['titulo'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(_paymentsController
                                              .inscriptionPayments[0]
                                          ['configuracion_pago']['detalle']),
                                      Text(
                                          'Valor: ${_paymentsController.inscriptionPayments[0]['configuracion_pago']['valor']}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),  
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    '¡Ok!',
                    '¡Comprobante de pago enviado!',
                  );
                },
                style: ElevatedButton.styleFrom(
                  // backgroundColor: listColor[16],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Enviar',
                  style: TextStyle(
                    //color: listColor[10],
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

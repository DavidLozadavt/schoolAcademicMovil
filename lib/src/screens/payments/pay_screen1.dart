import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/payments/payments_controller.dart';
import 'package:vtschool/src/widgets/loading.dart';

class PayScreen extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _paymentsController.isLoading.value
        ? const LoadingScreen()
        : Scaffold(
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(bottom: 80),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      listColor[14],
                      listColor[11],
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 80,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: listColor[10],
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Text(
                            'Pago matricula',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: listColor[10],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _paymentsController.tuitionPayments.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes pagos pendientes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => ListView(
                                      children: List.generate(
                                        _paymentsController
                                            .tuitionPayments.length,
                                        (index) {
                                          var payment = _paymentsController
                                              .tuitionPayments[index];
                                          var config =
                                              payment['configuracion_pago'];
                                          return CheckboxListTile(
                                            value: _paymentsController
                                                .selectedPayments
                                                .contains(payment['id']),
                                            onChanged: (bool? selected) {
                                              _paymentsController.togglePayment(
                                                  payment['id'],
                                                  config['valor']);
                                            },
                                            fillColor: MaterialStateProperty
                                                .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
                                                  return const Color(
                                                      0xff00C535);
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 171, 217, 255),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          config['titulo'],
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          config['detalle'],
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Image.network(
                                                        _paymentsController
                                                                        .tuitionPayments[
                                                                    index][
                                                                'configuracion_pago']
                                                            ['image'],
                                                        width: 60,
                                                      ),
                                                      Text(
                                                        '\$${_paymentsController.tuitionPayments[index]['configuracion_pago']['valor']}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 19, 19, 19),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Total: \$${_paymentsController.totalValue.value}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 110.0),
                          child: ElevatedButton(
                            onPressed: () async{
                              if (_paymentsController.totalValue.value != 0) {
                                await _paymentsController.getFinancialInstitutions();
                                Get.toNamed('/form_payments');
                              } else {
                                Get.defaultDialog(
                                  title: "¡Error!",
                                  content:
                                      const Text("Debe seleccionar un pago"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: listColor[13],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Pagar',
                              style: TextStyle(
                                color: listColor[10],
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
  }
}

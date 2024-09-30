import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/payments/payments_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PseScreen extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  late final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(_paymentsController.asyncPaymentUrl.value));
  PseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago PSE'),
      ),
      body: Obx(() {
        if (_paymentsController.asyncPaymentUrl.value.isNotEmpty) {
          return WebViewWidget(controller: _controller);
        } else {
          return const Center(
            child: Text('Se produjo un error vuelve a intentarlo'),
          );
        }
      }),
    );
  }
}

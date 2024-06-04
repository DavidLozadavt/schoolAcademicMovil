import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/payments/payments_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PruebaWompi extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  late final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    /*..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          CircularProgressIndicator();
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )*/
    ..loadRequest(Uri.parse(_paymentsController.asyncPaymentUrl.value));
  PruebaWompi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago PSE'),
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

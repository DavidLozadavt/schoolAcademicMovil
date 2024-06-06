import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Pagos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Image.asset(
              'assets/images/31.png',
              width: 250,
            ),
            const SizedBox(
              height: 90,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                children: [
                  InkWell(
                    onTap: () {},
                    child: cardPay(Icons.payment, 'Pago inscripcion'),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/pay');
                    },
                    child: cardPay(Icons.event_note_rounded, 'Pago matricula'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: cardPay(Icons.library_add_sharp, 'Pago pension'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: cardPay(Icons.paypal_rounded, 'Otros pagos'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardPay(IconData icon, String title) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: Colors.black12,
          //margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Card(
            elevation: 8.0,
            color: listColor[18],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                //fontWeight: FontWeight.w200,
                fontSize: 12,
                color: Colors.black),
          ),
        )
      ],
    );
  }
}

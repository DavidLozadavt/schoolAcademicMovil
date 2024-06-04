import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            const SizedBox(
              height: 25,
            ),
            Text(
              'Pagos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: listColor[10],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {},
                    child: cardPay(Icons.payment, 'Pago inscripcion')),
                InkWell(
                    onTap: () {
                      Get.toNamed('/pay');
                    },
                    child: cardPay(Icons.event_note_rounded, 'Pago matricula')),
                InkWell(
                    onTap: () {},
                    child: cardPay(Icons.library_add_sharp, 'Pago pension')),
                InkWell(
                    onTap: () {},
                    child: cardPay(Icons.paypal_rounded, 'Otros pagos')),
              ],
            ),
          
          ],
        ),
      ),
    );
  }

  Widget cardPay(IconData icon, String title) {
    return Container(
     // padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              icon,
              size: 80.0,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                //fontWeight: FontWeight.w200,
                fontSize: 12,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}

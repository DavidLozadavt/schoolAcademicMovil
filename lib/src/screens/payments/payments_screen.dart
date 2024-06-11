import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/widgets/drop_down_menu_item.dart';

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
                    onTap: () {
                      DropdownButton2(
                        underline: Container(),
                        isExpanded: true,
                        customButton: const Icon(
                          Icons.more_vert,
                          size: 34,
                          color: Colors.black,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          width: 165,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14, top: 5),
                        ),
                        items: [
                          customDropdownMenuItem(
                            text: 'Términos y condiciones',
                            enabled: true,
                            value: 3,
                            onTap: () {},
                          ),
                          /* _itemPopUpMenu(context, 'Editar perfil', true, 1,
                            () => Get.to(() => const PagosPage())),*/
                          /*_itemPopUpMenu(context, 'Términos y condiciones', true,
                            3, () => Get.to(const PagosPage())),*/
                        ],
                        onChanged: (value) {},
                      );
                    },
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

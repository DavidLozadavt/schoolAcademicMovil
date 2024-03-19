import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/profile/logout_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';
import 'package:vtschool/src/screens/wompi/wompi_servise.dart';

class ProfileUserScreen extends StatelessWidget {
  ProfileUserScreen({super.key});

  final ProfileUserController controller = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      } else {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  listColor[3],
                  listColor[2],
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropdownButton2(
                        underline: Container(),
                        isExpanded: true,
                        customButton: Icon(
                          Icons.more_vert,
                          size: 34,
                          color: listColor[0],
                        ),
                        dropdownStyleData: DropdownStyleData(
                          width: 165,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                listColor[2],
                                listColor[3],
                              ],
                            ),
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
                          _itemPopUpMenu(context, 'Editar perfil', true, 1,
                              () => Get.to(() => const PagosPage())),
                          /*_itemPopUpMenu(context, 'Términos y condiciones', true,
                              3, () => Get.to(const PagosPage())),*/
                          _itemPopUpMenu(context, 'Cerrar sesión', true, 4,
                              () => logoutApp(context)),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          '${controller.userProfile['persona']['rutaFoto']}',
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/scl2.jpg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${controller.userProfile['persona']['nombre1']} ${controller.userProfile['persona']['apellido1']}',
                            style: kTitleStylew,
                          ),
                          Text(
                            '${controller.userProfile['persona']['email']}',
                            style: kTlight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Información Personal",
                      style: kTitleStyleDark,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextFieldWithIcon(
                        "Telefono",
                        Icons.phone,
                        '${controller.userProfile['persona']['celular']}',
                      ),
                      const SizedBox(height: 10),
                      buildTextFieldWithIcon(
                        "Documento",
                        Icons.badge_outlined,
                        '${controller.userProfile['persona']['identificacion']}',
                      ),
                      const SizedBox(height: 10),
                      buildTextFieldWithIcon(
                        "Ciudad de nacimiento",
                        Icons.badge_outlined,
                        '${controller.userProfile['persona']['ciudad_nac']['descripcion']}',
                      ),
                      const SizedBox(height: 10),
                      buildTextFieldWithIcon(
                        "Ciudad actual",
                        Icons.location_city,
                        '${controller.userProfile['persona']['ciudad_ubicacion']['descripcion']}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  DropdownMenuItem _itemPopUpMenu(BuildContext context, String text,
      bool enabled, int value, Function onTap,
      {Color color = Colors.white,
      Color colorText = const Color(0XFF2D2D2D),
      Color colorBorder = const Color(0xFFFFC403)}) {
    return DropdownMenuItem(
      onTap: (() => onTap()),
      alignment: Alignment.center,
      enabled: enabled,
      value: value,
      child: Container(
        alignment: Alignment.center,
        decoration: enabled
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: colorBorder,
                ),
                color: color,
              )
            : null,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: enabled ? colorText : Colors.grey[300],
            fontSize: 12,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

Widget buildTextFieldWithIcon(String label, IconData icon, String value) {
  return Container(
    width: 900,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: const Color.fromARGB(255, 234, 231, 71),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: kTlightproSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                style: kTlightpro,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
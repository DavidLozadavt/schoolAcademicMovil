import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vtschool/src/screens/logout/logout_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';
import 'package:vtschool/src/widgets/drop_down_menu_item.dart';

class ProfileUserScreen extends StatelessWidget {
  ProfileUserScreen({super.key});

  final ProfileUserController _profileController =
      Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: DropdownButton2(
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
                      thickness: WidgetStateProperty.all<double>(6),
                      thumbVisibility: WidgetStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14, top: 5),
                  ),
                  items: [
                    //  customDropdownMenuItem(context, 'ACTUALIZAR PERFIL', true, 1,
                    //         () => Get.to(() => EnrollmentsPersonScreen())),
                    customDropdownMenuItem(
                        context, 'CAMBIAR CONTRASEÑA', true, 2, () async {
                      await Future.delayed(const Duration(seconds: 1), () {
                        Get.toNamed('/update_password');
                      });
                    }),
                    if (_profileController.rolUser == 'ACUDIENTE')
                      customDropdownMenuItem(
                          context, 'CAMBIAR ESTUDIANTE', true, 2, () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await Future.delayed(const Duration(seconds: 1), () {
                          Get.offAllNamed('/guardian_children');
                          pref.remove('idUser');
                        });
                      }),
                    customDropdownMenuItem(context, 'CERRAR SESIÓN', true, 3,
                        () => logoutApp(context)),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Obx(
            () => _profileController.isLoading.value
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
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
                            '${_profileController.userProfile['persona']?['rutaFoto']}',
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/profile.png',
                                width: 60,
                                height: 60,
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
                                '${_profileController.userProfile['persona']?['nombre1']} ${_profileController.userProfile['persona']?['apellido1']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'CM Sans Serif',
                                  fontSize: 24.0,
                                )),
                            Text(
                              '${_profileController.userProfile['persona']?['email']}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Averta_Light',
                                  fontSize: 13.0,
                                  height: 1.5,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
          Obx(
            () => _profileController.isLoading.value
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "INFORMACIÓN PERSONAL",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CM Sans Serif',
                            fontSize: 16.0,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildTextFieldWithIcon(
                          "TELEFONO",
                          Icons.phone,
                          '${_profileController.userProfile['persona']?['celular']}',
                        ),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "DOCUMENTO",
                          Icons.badge_outlined,
                          '${_profileController.userProfile['persona']?['identificacion']}',
                        ),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "CIUDAD DE NACIMIENTO",
                          Icons.badge_outlined,
                          '${_profileController.userProfile['persona']?['ciudad_nac']['descripcion']}',
                        ),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "CIUDAD ACTUAL",
                          Icons.location_city,
                          '${_profileController.userProfile['persona']?['ciudad_ubicacion']['descripcion']}',
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

Widget buildTextFieldWithIcon(String label, IconData icon, String value) {
  return Container(
    width: 900,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.black12,
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Averta_Light',
                  fontSize: 12.0,
                  height: 1.5,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                value,
                style: const TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Averta_Light',
                    fontSize: 20.0,
                    height: 1.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

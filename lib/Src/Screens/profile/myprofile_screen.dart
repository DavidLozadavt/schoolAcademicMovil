// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vtschool/Src/Controllers/perfil_controller.dart';
import 'package:vtschool/Src/Models/user_profile_model.dart';
import 'package:vtschool/Src/Provider/theme_dark_or_light.dart';
import 'package:vtschool/Src/Widgets/custom_loading_screen.dart';
import 'package:vtschool/Src/Config/fonts_styles.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  UserData? userProfile;
  bool isLoading = true;
  final ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    _profileController.fetchAndSetProfileData(getProfileData);
  }

  void getProfileData(UserData? profile, bool loading) {
    setState(() {
      userProfile = profile;
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text(
            "Mi Perfil",
            style: kTitleStylew,
          ),
        ),
      ),
      // endDrawer: Drawer(
      //   width: 230,
      //   elevation: 0,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //           padding: const EdgeInsets.only(top: 90, left: 20),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(15),
      //             color: const Color.fromARGB(255, 234, 231, 71),
      //           ),
      //           child: const Row(
      //             children: [
      //               Text('Ajustes', style: kTitleStylew),
      //               SizedBox(
      //                 width: 5,
      //               ),
      //               Icon(Icons.settings)
      //             ],
      //           )),
      //       Container(
      //         margin: const EdgeInsets.all(12),
      //         child: Column(
      //           children: [
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             const IconThemoMode(),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             ElevatedButton(
      //                 onPressed: () {
      //                   Get.back();
      //                   Get.toNamed('/update_profile');
      //                 },
      //                 child: const Row(
      //                   children: [
      //                     Icon(Icons.settings),
      //                     SizedBox(
      //                       width: 5,
      //                     ),
      //                     Text('Actualizar Perfil'),
      //                   ],
      //                 )),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             ElevatedButton(
      //               onPressed: () {
      //                  Get.back();
      //                 logoutApp(context);
      //               },
      //               child: const Row(
      //                 children: [
      //                   Icon(Icons.logout_outlined),
      //                   SizedBox(
      //                     width: 5,
      //                   ),
      //                   Text('Cerrar sesión'),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        child: isLoading
            ? const Center(
                child: CustomLoadingScreen(),
              )
            : Column(
                children: [
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
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                          backgroundImage: isLoading
                              ? null
                              : NetworkImage(
                                  '${userProfile?.userData.persona.rutaFotoUrl}',
                                ),
                          child: const Stack(
                            alignment: Alignment.bottomRight,
                            children: [],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${userProfile?.userData.persona.nombre1} ${userProfile?.userData.persona.apellido1}',
                              style: kTitleStylew,
                            ),
                            Text(
                              '${userProfile?.userData.persona.email}',
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
                          '${userProfile?.userData.persona.celular}',
                        ),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "Documento",
                          Icons.badge_outlined,
                          '${userProfile?.userData.persona.identificacion}',
                        ),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "Ciudad de nacimiento",
                          Icons.badge_outlined,
                          '${userProfile?.userData.persona.ciudadNac.descripcion}',
                        ),
                       const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "Ciudad actual",
                          Icons.location_city,
                          '${userProfile?.userData.persona.ciudadUbicacion.descripcion}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
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
}




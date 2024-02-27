// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vtschool/Src/Models/api_response_model.dart';
import 'package:vtschool/Src/Models/ciudad_model.dart';
import 'package:vtschool/Src/Models/user_profile_model.dart';
import 'package:vtschool/Src/Services/ciudad_service.dart';
import 'package:vtschool/Src/Services/update_profile_user.dart';
import 'package:vtschool/Src/Services/auth_service.dart';
import 'package:vtschool/Src/Widgets/custom_loading_screen.dart';
import 'package:vtschool/Src/Config/fonts_styles.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? selectedImages;
  bool imageSelected = false;

  UserData? userProfile;
  bool isLoading = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtNombre1 = TextEditingController();
  TextEditingController txtNombre2 = TextEditingController();
  TextEditingController txtApellido1 = TextEditingController();
  TextEditingController txtApellido2 = TextEditingController();
  TextEditingController txtTelefono = TextEditingController();

  List<Ciudad> ciudades = [];
  Ciudad? selectedCiudad;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
    fetchCiudadesFromAPI();
  }

  Future<void> fetchCiudadesFromAPI() async {
    try {
      List<Ciudad> fetchedCiudades = await fetchCiudades();
      setState(() {
        ciudades = fetchedCiudades;
      });
    } catch (e) {
      print('Error fetching ciudades: $e');
    }
  }

  Future<void> fetchProfileData() async {
    ApiResponse apiResponse = await getProfile();

    if (apiResponse.error != null) {
    } else {
      setState(
        () {
          userProfile = apiResponse.data as UserData?;
          txtNombre1.text = userProfile?.userData.persona.nombre1 ?? '';
          txtNombre2.text = userProfile?.userData.persona.nombre2 ?? '';
          txtApellido1.text = userProfile?.userData.persona.apellido1 ?? '';
          txtApellido2.text = userProfile?.userData.persona.apellido2 ?? '';

          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 231, 71),
        elevation: 0,
        title: const Center(
          child: Text(
            "Actualizar perfil",
            style: kTitleStylew,
          ),
        ),
      ),
      body: Container(
        child: isLoading
            ? const Center(
                child: CustomLoadingScreen(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 231, 71),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: selectedImages != null
                                ? Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 234, 231, 71),
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const SizedBox(width: 8),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          child: Image.file(
                                            selectedImages!,
                                            width: 160,
                                            height: 160,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 80,
                                    backgroundColor:
                                        const Color.fromRGBO(0, 0, 0, 1),
                                    backgroundImage:
                                        isLoading ? null : NetworkImage(''),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [],
                                    ),
                                  ),
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
                      height: 20,
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          buildTextFieldWithIcon(
                            'Primer Nombre',
                            Icons.mode_edit,
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                decoration: kInputDecoration2(),
                                controller: txtNombre1,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                maxLength: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buildTextFieldWithIcon(
                            'Segundo Nombre',
                            Icons.mode_edit,
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                decoration: kInputDecoration2(),
                                controller: txtNombre2,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                maxLength: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buildTextFieldWithIcon(
                            'Primer Apellido',
                            Icons.mode_edit,
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                decoration: kInputDecoration2(),
                                controller: txtApellido1,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.streetAddress,
                                maxLength: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buildTextFieldWithIcon(
                            'Segundo Apellido',
                            Icons.mode_edit,
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                decoration: kInputDecoration2(),
                                controller: txtApellido2,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                maxLength: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField<Ciudad>(
                            value: selectedCiudad ??
                                ciudades.firstWhere(
                                    (ciudad) =>
                                        ciudad.id ==
                                        userProfile?.userData.persona
                                            .ciudadUbicacion.id,
                                    orElse: () => ciudades.first),
                            onChanged: (Ciudad? newValue) {
                              setState(() {
                                selectedCiudad = newValue;
                                // Aquí puedes imprimir el ID de la ciudad seleccionada
                                if (newValue != null) {
                                  print(
                                      'ID de la ciudad seleccionada: ${newValue.id}');
                                }
                              });
                            },
                            items: ciudades.map((ciudad) {
                              return DropdownMenuItem<Ciudad>(
                                value: ciudad,
                                child: Text(ciudad.descripcion),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.amber),
                            ),
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Actualizando Perfil'),
                                      content: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: Center(
                                          child: Image.asset(
                                              "assets/animations/logo-3.gif"),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                           await Future.delayed(
                                    const Duration(seconds: 3));

                                int? ciudadId = selectedCiudad?.id;

                                updateProfile(
                                  nombre1: txtNombre1.text,
                                  nombre2: txtNombre2.text,
                                  apellido1: txtApellido1.text,
                                  apellido2: txtApellido2.text,
                                  idCiudadUbicacion: ciudadId.toString(),
                                );
                             

                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildTextFieldWithIcon(String label, IconData icon, SizedBox value) {
    return Container(
      width: 320,
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: kTlightproSmall,
              ),
              Padding(padding: const EdgeInsets.all(1.0), child: value),
            ],
          ),
        ],
      ),
    );
  }
}

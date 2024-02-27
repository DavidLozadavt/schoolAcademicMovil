// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config/fonts_styles.dart';
import '../../Models/api_response_model.dart';
import '../../Models/auth_user_model.dart';
import '../../Services/auth_service.dart';
import '../../Widgets/alert.dart';
import '../../Widgets/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtDocument = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtNumberPhone = TextEditingController();
  bool _passwordVisible = false;

  String dropdownValueState = 'CC';
  createAccountPressed() async {
    try {
      String? typeDocument = GetStorage().read('typeDocument');
      typeDocument ??= "1";
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(txtEmail.text);
      if (emailValid) {
        ApiResponse response = await register(
            txtName.text,
            txtLastName.text,
            typeDocument,
            txtDocument.text,
            txtEmail.text,
            txtPassword.text,
            txtNumberPhone.text);
        // ignore: use_build_context_synchronously
        if (response.error == null) {
          setState(() {
            GetStorage().remove('typeDocument');
          });
          Alert.snacbarSuccess(
              context: context, title: 'Registrado', message: '¡Bienvenido!');
          _saveAndRedirectToHome(response.data as User);
        } else {
          Alert.snacbarError(
              context: context,
              title: 'Error',
              message: 'Su identificacion o correo ya se encuentra registrado');
        }
      } else {
        Alert.snacbarWarning(
            context: context,
            title: '¡Ups!',
            message: 'Correo invalido',
            duration: const Duration(seconds: 3));
      }
    } catch (e) {
      Alert.snacbarWarning(
          context: context,
          title: 'Documento',
          message: 'Seleccione su tipo de documento',
          duration: const Duration(seconds: 3));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token);
    await pref.setString('email', txtEmail.text);
    await pref.setString('contrasena', txtPassword.text);

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    "assets/images/taxi_login.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: const Text(
                    "REGISTRO",
                    style: kTitleStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 10),
                    child: Card(
                      color: Colors.white.withOpacity(0.8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                decoration: kInputDecoration('Nombre'),
                                keyboardType: TextInputType.name,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                controller: txtName,
                                validator: (val) =>
                                    val!.isEmpty ? 'Escribe tu nombre' : null,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: kInputDecoration(
                                    'Apellido'), // Utiliza la misma decoración
                                controller: txtLastName,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (val) =>
                                    val!.isEmpty ? 'Escribe tu apellido' : null,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      validator: (val) => val!.isEmpty
                                          ? 'Escribe tu identificación'
                                          : null,
                                      decoration:
                                          kInputDecoration('Identificación'),
                                      keyboardType: TextInputType.phone,
                                      controller: txtDocument,
                                      maxLength: 20,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownValueState,
                                    items: <String>['CC', 'TI', 'PASS', 'CE']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      updateTypeDocument(newValue!);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: kInputDecoration('Email'),
                                keyboardType: TextInputType.emailAddress,
                                controller: txtEmail,
                                validator: (val) =>
                                    val!.isEmpty ? 'Escribe tu correo' : null,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (val) => val!.length < 8
                                    ? 'La contraseña debe tener al menos 8 caracteres'
                                    : null,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !_passwordVisible,
                                controller: txtPassword,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: kInputDecoration('Celular'),
                                controller: txtNumberPhone,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                validator: (val) => val!.length < 10
                                    ? 'El telfono debe tener 10 caracteres'
                                    : null,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              RoundedButton(
                                btnText: 'Create Account',
                                onBtnPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    createAccountPressed();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push('/login');
                                },
                                child: const Text('Already have an account',
                                    style: TextStyle()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTypeDocument(String newValue) async {
    String? typeDocument;
    switch (newValue) {
      case 'CC':
        typeDocument = '1';
        break;
      case 'TI':
        typeDocument = '2';
        break;
      case 'PASS':
        typeDocument = '3';
        break;
      case 'CE':
        typeDocument = '4';
        break;
      default:
        typeDocument = '1';
    }

    await GetStorage().write('typeDocument', typeDocument);
    setState(() {
      dropdownValueState = newValue;
    });
  }
}

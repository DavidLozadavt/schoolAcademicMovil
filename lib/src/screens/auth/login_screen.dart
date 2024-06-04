import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    _loginController.loadEmailFromPrefs();
    return Scaffold(
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 15,
            ),
            _header(context),
            Container(
              margin: const EdgeInsets.all(24),
              child: _inputField(context),
            ),
            _loginButton(context),
            _forgotPassword(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        /*const Text(
          "SCHOOL",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Ingrese sus credenciales", style: kTlight),*/
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/logo_school.png',
          width: 200,
        )
      ],
    );
  }

  _inputField(context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 50,
          child: TextField(
            controller: _loginController.emailController,
            decoration: InputDecoration(
              hintText: "Correo",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: listColor[10],
              filled: true,
              prefixIcon: Icon(
                Icons.person,
                color: listColor[13],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 50,
          child: TextField(
            controller: _loginController.passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: "Contraseña",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: listColor[10],
              filled: true,
              prefixIcon: Icon(
                Icons.password_rounded,
                color: listColor[13],
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _loginController.togglePasswordVisibility();
                  Get.forceAppUpdate();
                },
                child: Obx(() => Icon(
                      _loginController.passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    )),
              ),
            ),
            obscureText: !_loginController.passwordVisible.value,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "¿Olvido su contraseña?",
        style: TextStyle(color: listColor[10]),
      ),
    );
  }

  /*_signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "No tienes una cuenta?",
          style: kTlight,
        ),
        TextButton(
          onPressed: _loginController.goToRegisterPage,
          child: const Text(
            "Sign Up",
            style: TextStyle(color:  Color(0xFFFFC502)),
          ),
        )
      ],
    );
  }*/
  /*_loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _loginController.login,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color(0xFFFFC502),
      ),
      child: const Text(
        'Login',
        style: kTitleStyleDark,
      ),
    );
  }*/

  _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110.0),
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).requestFocus();
           _loginController.login();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: listColor[13],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            color: listColor[10],
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  
}

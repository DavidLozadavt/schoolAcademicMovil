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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    const SizedBox(
                      height: 75,
                    ),
                    Container(
                      margin: const EdgeInsets.all(24),
                      child: _inputField(context),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    _loginButton(context),
                    const SizedBox(
                      height: 25,
                    ),
                    _forgotPassword(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _header(context) {
    return Image.asset(
      'assets/images/logo_school.png',
      width: 200,
    );
  }

  _inputField(context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: listColor[10],
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: listColor[15].withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
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
                color: listColor[15],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: listColor[10],
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: listColor[15].withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(() {
            return TextField(
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
                  color: listColor[15],
                ),
                suffixIcon: Obx(() => IconButton(
                    onPressed: _loginController.togglePasswordVisibility,
                    icon: Icon(
                      _loginController.passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: _loginController.passwordVisible.value
                          ? listColor[16]
                          : listColor[15],
                    ))),
              ),
              obscureText: !_loginController.passwordVisible.value,
            );
          }),
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
          backgroundColor: listColor[16],
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

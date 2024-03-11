import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:vtschool/src/screens/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    _loginController.loadEmailFromPrefs();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(1.0),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _header(context),
              _inputField(context),
              _loginButton(context),
              _forgotPassword(context),
              //_signup(context),
            ],
          ),
        ),
      ),
    );
  }
  _header(context) {
    return Column(
      children: [
        const Text(
          "SCHOOL",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Ingrese sus credenciales", style: kTlight),
        const SizedBox(height: 20),
        Image.asset('assets/images/logon.png')
      ],
    );
  }
  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _loginController.emailController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _loginController.passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password_outlined),
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
        const SizedBox(height: 10),
      ],
    );
  }
  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color:  Color(0xFFFFC502)),
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
  _loginButton(BuildContext context) {
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
  }
}

// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/Src/Config/fonts_styles.dart';
import 'package:vtschool/Src/Models/api_response_model.dart';
import 'package:vtschool/Src/Models/auth_user_model.dart';
import 'package:vtschool/Src/Services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  bool _passwordVisible = false;

  void _loginUser() async {
  
    ApiResponse response = await login(txtEmail.text, txtPassword.text);

    if (response.error == null) {
      Get.snackbar(
        'Hola!',
        'Un gusto tenerte nuevamente!',
      );

      setState(() {
        loading = true;
      });
      _saveAndRedirectToHome(response.data as User);
    } else {
      Fluttertoast.showToast(
        msg: 'Correo o contraseña incorrectos',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
      );

      setState(() {
        loading = false;
      });
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token);
    await pref.setString('email', txtEmail.text);
    await pref.setString('contrasena', txtPassword.text);

    Get.toNamed('/home');
  }

  void _loadSavedCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? savedEmail = pref.getString('email');
    String? savedPassword = pref.getString('contrasena');
    if (savedEmail != null && savedPassword != null) {
      txtEmail.text = savedEmail;
      txtPassword.text = savedPassword;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(1.0),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return  Column(
      children: [
        Text(
          "SCHOOL",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Ingrese sus credenciales", style: kTlight),
        SizedBox(height: 20),
        Image.asset('assets/images/logon.png')
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: txtEmail,
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
          controller: txtPassword,
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
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          obscureText: !_passwordVisible,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            _loginUser();
            setState(() {
              loading = false;
            });
          },
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFFFFC502),
          ),
          child: loading
              ? CircularProgressIndicator()
              : Text(
                  'Login',
                  style: kTitleStyleDark,
                ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: const Color(0xFFFFC502)),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes una cuenta?", style: kTlight,),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Sign Up",
            style: TextStyle(color: const Color(0xFFFFC502)),
          ),
        )
      ],
    );
  }

}

//   void _showLoginAlert(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Text(
//             'Iniciando sesión',
//             style: kTlightproMax,
//           ),
//           content: const Row(
//             children: <Widget>[
//               CircularProgressIndicator(),
//               SizedBox(width: 20),
//               Text(
//                 'Por favor, espera un momento...',
//                 style: kTlight,
//               ),
//             ],
//           ),
//           actions: [],
//         );
//       },
//     );
//   }
// }

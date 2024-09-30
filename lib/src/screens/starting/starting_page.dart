import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipPath(
                clipper: OvalClipper(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/chica2.png',
                    width: 100,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 55.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '¡Bienvenido ',
                          style: TextStyle(
                            color: listColor[15],
                            fontFamily: 'CM Sans Serif',
                            fontSize: 24.0,
                            height: 1.5,
                          ),
                        ),
                        const TextSpan(
                          text: 'a School, tú nuevo \n  compañero escolar',
                          style: TextStyle(
                            color: Colors.black38,
                            fontFamily: 'CM Sans Serif',
                            fontSize: 26.0,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '! 📚',
                          style: TextStyle(
                            color: listColor[15],
                            fontFamily: 'CM Sans Serif',
                            fontSize: 24.0,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '¡Has tú educación mas divertida! ',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: listColor[15],
                        fontFamily: 'Averta_Light',
                        fontSize: 14.0,
                        height: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 90),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: listColor[15],
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 120.0),
                    ),
                    child:
                        Text('Vamos', style: TextStyle(color: listColor[17])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.9, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

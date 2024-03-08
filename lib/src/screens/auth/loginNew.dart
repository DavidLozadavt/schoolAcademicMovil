import 'package:flutter/material.dart';
import 'package:vtschool/src/config/fonts_styles.dart';

class LoginNew extends StatelessWidget {
  const LoginNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8A2387),
                Color(0xFFE94057),
                Color(0xFFF27121),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/images/avatar.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                'Tu logo',
                style: kTitleStylew,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 480,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Login',
                      style: kTlightproMax,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Por favor inicia con tu cuenta',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

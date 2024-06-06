import 'package:flutter/material.dart';
import 'package:vtschool/src/config/fonts_styles.dart';

class CustomLoadingScreen extends StatelessWidget {
  final Color backgroundColor;
  const CustomLoadingScreen({Key? key, this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
              Image.asset(
              'assets/images/intento.gif',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            const Text('Cargando',
            style: kTlightpro), 
          ],
        ),
      ),
    );
  }
}
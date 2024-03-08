// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../config/fonts_styles.dart';

class CustomLoadingScreen extends StatefulWidget {
  final Color backgroundColor; 
  const CustomLoadingScreen({Key? key, this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  _CustomLoadingScreenState createState() => _CustomLoadingScreenState();
}

class _CustomLoadingScreenState extends State<CustomLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: widget.backgroundColor, 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
              Image.asset(
              'assets/animations/logo-3.gif',
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
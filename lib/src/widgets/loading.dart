import 'package:flutter/material.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

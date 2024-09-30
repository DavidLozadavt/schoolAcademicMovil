/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/fonts_styles.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;

  const CustomAlert({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: kTlightproMax,
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: kTlight,
              ),
              const SizedBox(height: 10),
              Image.asset(
                imagePath,
                width: 100,
                height: 70,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/banner');
                },
                child: const Text(
                  'Ir a pagar',
                  style: kTlight,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BannerInfo extends StatelessWidget {
  const BannerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/banner-tambo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Center(
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black, size: 10),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

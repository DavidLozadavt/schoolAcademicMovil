import 'package:flutter/material.dart';

class ContSup extends StatelessWidget {
  const ContSup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.height * 0.0045,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 217, 217),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.001),
      ],
    );
  
  }
}
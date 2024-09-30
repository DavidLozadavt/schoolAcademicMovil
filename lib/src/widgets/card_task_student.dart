import 'package:flutter/material.dart';

class CardTaskStudent extends StatelessWidget {
  final String idActivity;
  final String affair;
  final String urlPhotoSender;
  final String nameOfsender;
  final String initialDate;
  final String finalDate;
  final String subject;
  final String status;

  const CardTaskStudent({
    required this.idActivity,
    required this.affair,
    required this.urlPhotoSender,
    required this.nameOfsender,
    required this.initialDate,
    required this.finalDate,
    required this.subject,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: getRandomColor(),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey[400]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                affair,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(urlPhotoSender),
                    radius: 25,
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Docente: $nameOfsender',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Materia: $subject',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Fecha inicial: $initialDate',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Fecha final: $finalDate',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/libro-vt.png',
                  width: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   Color getRandomColor() {
    if (status == 'ACTIVO') {
      return const Color.fromARGB(255, 157, 219, 129);
    } else if (status == 'ACEPTADO' || status == 'PENDIENTE') {
      return const  Color(0xFFFFDC4A);
    }  else {
      return const Color.fromARGB(255, 247, 141, 141);
    }
  }
}

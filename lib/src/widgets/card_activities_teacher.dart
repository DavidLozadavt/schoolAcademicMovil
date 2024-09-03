import 'package:flutter/material.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class CardActivitiesTeacher extends StatelessWidget {
  final String idActivity;
  final String affair;
  final String urlPhotoSender;
  final String nameOfSender;
  final String initialDate;
  final String finalDate;
  final String subject;

  const CardActivitiesTeacher({
    required this.idActivity,
    required this.affair,
    required this.urlPhotoSender,
    required this.nameOfSender,
    required this.initialDate,
    required this.finalDate,
    required this.subject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: listColor[12].withOpacity(0.4),
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
                          'Docente: $nameOfSender',
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
}

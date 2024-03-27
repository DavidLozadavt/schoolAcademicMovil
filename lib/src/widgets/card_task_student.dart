import 'package:flutter/material.dart';

class CardTaskStudent extends StatelessWidget {
  final String idActivity;
  final String affair;
  final String urlPhotoSender;
  final String nameOfsender;
  final String initialDate;
  final String finalDate;

  const CardTaskStudent({
    required this.idActivity,
    required this.affair,
    required this.urlPhotoSender,
    required this.nameOfsender,
    required this.initialDate,
    required this.finalDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateToday = DateTime.now();
    DateTime final_date = DateTime.parse(finalDate);
    int comparacion = final_date.compareTo(dateToday);
   
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: comparacion > 0 ? Colors.grey[200] : Color.fromARGB(255, 255, 144, 144),
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
                    backgroundImage: NetworkImage(
                      urlPhotoSender
                      ),
                    radius: 25,
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
                         Text(
                          comparacion > 0 ? '' : 'Actividad no contestada',
                          style: TextStyle(
                            fontSize: 12,
                            color: comparacion > 0 ? Colors.black : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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

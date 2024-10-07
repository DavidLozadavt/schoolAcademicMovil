import 'package:flutter/material.dart';

class CardEnrollmentsPerson extends StatelessWidget {
  final String date;
  final String name;
  final String lastName;
  final String program;
  final String gradeOrSemester;
  final String educationalLevel;
  final String status;

  const CardEnrollmentsPerson({
    required this.date,
    required this.name,
    required this.lastName,
    required this.program,
    required this.gradeOrSemester,
    required this.educationalLevel,
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
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey[400]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: $name $lastName',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Fecha: $date',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Programa: $program',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Semestre/Grado: $gradeOrSemester',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Nivel educativo: $educationalLevel',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Estado: $status',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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

  Color getRandomColor() {
    if (status == 'ACTIVO') {
      return const Color.fromARGB(255, 157, 219, 129);
    } else if (status == 'ACEPTADO' || status == 'PENDIENTE') {
      return const Color(0xFFFFDC4A);
    } else {
      return const Color.fromARGB(255, 247, 141, 141);
    }
  }
}

import 'package:flutter/material.dart';

class CardStudent extends StatelessWidget {
  final String name;
  final String subject;
  final String urlPhotoStudent;
  final String attendant;
  final int qualification;

  const CardStudent({
    required this.name,
    required this.subject,
    required this.urlPhotoStudent,
    required this.attendant,
    required this.qualification,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        width: 370,
        decoration: BoxDecoration(
          color: getRandomColor(),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(urlPhotoStudent),
                    radius: 25,
                    backgroundColor: const Color.fromARGB(255, 236, 199, 199),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subject,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Padre: $attendant',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '$qualification',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.checklist_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
  if (qualification >= 4.6) {
    return const Color(0xFF749E60);
  } else if (qualification >= 4.0 && qualification < 4.6) {
    return const Color(0xFF7ECD57);
  } else if (qualification > 3.0 && qualification < 4.0) {
    return const Color(0xFFF44E1A);
  } else {
    return const Color(0xFFD63A3A);
  }
}

}

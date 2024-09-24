import 'dart:ui';
import 'package:flutter/material.dart';

class CardStudent extends StatelessWidget {
  final String name;
  final String subject;
  final String urlPhotoStudent;
  final String attendant;
  final int qualification;
  final VoidCallback onTapChat;

  const CardStudent({
    required this.name,
    required this.subject,
    required this.urlPhotoStudent,
    required this.attendant,
    required this.qualification,
    required this.onTapChat,
    super.key,
  });

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(urlPhotoStudent),
                    radius: 25,
                    backgroundColor: const Color.fromARGB(255, 236, 199, 199),
                  ),
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subject,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           Text(
                             'Padre: $attendant',
                             style: const TextStyle(
                               color: Colors.white,
                               fontSize: 12,
                               fontWeight: FontWeight.bold,
                             ),
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
                  ),
                  Column(
                    children: [
                      Checkbox(
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color(0xff00C535);
                            }
                            return Colors.white;
                          },
                        ),
                        value: false,
                        onChanged: (bool? value) {},
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                      ),
                      IconButton(
                        onPressed: onTapChat,
                        icon: const Icon(Icons.message),
                        color: Colors.white,
                      ),
                    ],
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

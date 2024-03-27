import 'package:flutter/material.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class CardNotifications extends StatelessWidget {

  final String idActivity;
  final String affair;
  final String date;
  final String hour;
  final String status;
  //final Function onTap;

  const CardNotifications({
    required this.idActivity,
    required this.affair,
    required this.date,
    required this.hour,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child:Container(
          height: 60,
          width: 350,
          decoration: BoxDecoration(
            color: status == 'ACTIVO' ? listColor[10].withOpacity(0.7) : listColor[12].withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(255, 129, 129, 129),
            ),
          ),
          child: Column(
            children: [
              Text(affair,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(date, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 10),
                  Text(hour, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

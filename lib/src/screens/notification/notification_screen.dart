import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              listColor[3],
              listColor[2],
            ],
          ),
        ),
        child:  Center(
          child: Column(
            children: [
              CupertinoButton(child: 
              Icon(Icons.replay_outlined), onPressed: (){
                Get.back();
              }),
              Text('Title'),
              Text('Body:'),
              Text('Data:'),
            ],
          ),
        ),
      ),
    );
  }
}

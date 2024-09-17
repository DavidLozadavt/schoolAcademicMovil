import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  var totalPoints = 5.0.obs;
  var currentPoints = 0.0.obs;
  var questions = [
    {
      'question': '¿Cuál es la capital de Francia?',
      'maxPoints': 1,
      'userPoints': 0.0
    },
    {
      'question': 'Define el concepto de democracia.',
      'maxPoints': 1,
      'userPoints': 0.0
    },
    {'question': '¿Qué es la fotosíntesis?', 'maxPoints': 1, 'userPoints': 0.0},
    {'question': '¿Qué es la fotosíntesis?', 'maxPoints': 1, 'userPoints': 0.0},
    {'question': '¿Qué es la fotosíntesis?', 'maxPoints': 1, 'userPoints': 0.0},
  ].obs;

  void updatePoints(int index, double points) {
    currentPoints.value = 0;

    questions[index]['userPoints'] = points;

    questions.forEach((q) {
      currentPoints.value += (q['userPoints'] as num);
    });
  }
}

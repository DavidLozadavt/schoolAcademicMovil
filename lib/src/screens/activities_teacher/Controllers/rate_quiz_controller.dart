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

    for (var q in questions) {
      currentPoints.value += (q['userPoints'] as num);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/Controllers/rate_quiz_controller.dart';

class RateQuestionnaireScreen extends StatelessWidget {
  const RateQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(QuizController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calificar Cuestionario',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progreso de la Calificación:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: controller.totalPoints.value > 0
                          ? controller.currentPoints.value /
                              controller.totalPoints.value
                          : 0.0,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blueAccent,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Puntuación: ${controller.currentPoints}/${controller.totalPoints}',
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.questions.length,
                    itemBuilder: (context, index) {
                      var question = controller.questions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mostrar el texto de la pregunta
                              Row(
                                children: [
                                  const Icon(Icons.question_mark,
                                      color: Colors.blueAccent),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      question['question'] as String,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                             const SizedBox(height: 10),
                              // Mostrar puntos obtenidos
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children:  [
                                      const Icon(Icons.score,
                                          color: Colors.greenAccent),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Puntos: ${question['userPoints']}/${question['maxPoints']}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[800]),
                                      ),
                                    ],
                                  ),
                                  _buildPointInput(controller, index,
                                      question['maxPoints'] as int),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Finalizar Calificación"),
                      content: const Text(
                          "¿Estás seguro de que deseas finalizar la calificación?"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: const Text("Finalizar"),
                          onPressed: () {
                            Get.snackbar(
                              'Finalizado',
                              'Has completado la calificación',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.blueAccent,
                              colorText: Colors.white,
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Finalizar Calificación'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointInput(QuizController controller, int index, int maxPoints) {
    TextEditingController textController = TextEditingController(
      text: controller.questions[index]['userPoints']
          .toString(), 
    );

    return Row(
      children: [
        const Text('Calificar: '),
        SizedBox(
          width: 50, 
          child: TextField(
            controller: textController,
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Puntos',
            ),
            onChanged: (value) {
              double points = double.tryParse(value) ??
                  0.0; 
              if (points > maxPoints) {
                Get.snackbar(
                  'Advertencia',
                  'El valor no puede exceder los puntos máximos ($maxPoints). Se ajustará automáticamente.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
                points = maxPoints
                    .toDouble();
                textController.text = points
                    .toString(); 
                textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: textController.text.length),
                );
              }
              controller.updatePoints(
                  index, points); 
            },
          ),
        ),
        Text(' / $maxPoints'),
      ],
    );
  }
}

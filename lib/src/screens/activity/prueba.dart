/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Prueba extends StatelessWidget {
  const Prueba({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget prueba(BuildContext context, activityData) {
    return Column(
      children: activityData['preguntas'].map<Widget>((pregunta) {
        if (pregunta['idTipoPregunta'] == 3) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pregunta['descripcion'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: pregunta['respuestas'].map<Widget>((respuesta) {
                  return Row(
                    children: [
                      Obx(() => CupertinoRadio(
                                      value: true,
                                      groupValue: _taskStudentController
                                          .isCheckedList[index]
                                          .value,
                                      activeColor: const Color(0xff00C535),
                                      onChanged: (bool? value) {
                                        print(value);
                                        _taskStudentController
                                            .isCheckedList[index]
                                            .value = value ?? false;
                                        _taskStudentController
                                                .isCheckedList[index]
                                                .value =
                                            value ?? false;
                                      },
                                    ),),
                      Text(
                        respuesta['descripcionRespuesta'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Text(
                pregunta['descripcion'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
      }).toList(),
    );
  }
}
*/
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_media_downloader/flutter_media_downloader.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/activity/task_student_controller.dart';
import 'package:vtschool/src/widgets/card_questions.dart';
import 'package:vtschool/src/widgets/card_task_student.dart';
import 'package:vtschool/src/widgets/cont_sup.dart';

class TaskStudentScreen extends StatelessWidget {
  final TaskStudentController _taskStudentController =
      Get.put(TaskStudentController());
  final TextEditingController _searchController = TextEditingController();
  final _flutterMediaDownloaderPlugin = MediaDownload();

  TaskStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _taskStudentController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      listColor[14],
                      listColor[11],
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      height: 80,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: listColor[10],
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Text(
                            'Mis tareas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: listColor[10],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 18.0, right: 18.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          _taskStudentController.filterActivities(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: listColor[11],
                          hintText: "Buscar",
                          hintStyle: TextStyle(color: listColor[14]),
                          prefixIcon: Icon(
                            Icons.search,
                            color: _searchController.text.isNotEmpty
                                ? Colors.white
                                : listColor[14],
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: listColor[14],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _searchController.text.isNotEmpty
                                  ? Colors.white
                                  : listColor[14],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 7.0),
                        ),
                        style: TextStyle(
                          color: listColor[10],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _taskStudentController.filteredActivities.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes actividades',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _taskStudentController
                                  .filteredActivities.length,
                              itemBuilder: ((context, index) {
                                Map<String, dynamic> decodedData = jsonDecode(
                                    _taskStudentController
                                            .filteredActivities[index]
                                        ['metadataInfo']);
                                int idActividad = decodedData['idActividad'];
                                String initialDate =
                                    decodedData['fechaInicial'];
                                String finalDate = decodedData['fechaFinal'];
                                String subject = decodedData['nombreMateria'];
                                if (_taskStudentController
                                            .filteredActivities[index]
                                        ['idTipoNotificacion'] !=
                                    4) {
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        await _taskStudentController
                                            .getTypeActivity('$idActividad');
                                        if (_taskStudentController
                                                    .typeActivitiesById[
                                                'tipoActividad'] ==
                                            'Normal') {
                                          await _taskStudentController
                                              .getActivityById('$idActividad');
                                          showNormalActivity(
                                              context,
                                              _taskStudentController
                                                  .activitiesById);
                                        } else {
                                          await _taskStudentController
                                              .getActivityQuestionnaire(
                                                  '$idActividad');
                                          showQuestionnaireActivity(
                                              context,
                                              _taskStudentController
                                                  .activityQuestionnaire);
                                        }
                                      },
                                      child: CardTaskStudent(
                                        idActivity:
                                            '${_taskStudentController.filteredActivities[index]['id']}',
                                        affair:
                                            '${_taskStudentController.filteredActivities[index]['asunto']}',
                                        urlPhotoSender:
                                            '${_taskStudentController.filteredActivities[index]['personaRemitente']['rutaFoto']}',
                                        nameOfsender:
                                            '${_taskStudentController.filteredActivities[index]['personaRemitente']['nombre1']} ${_taskStudentController.filteredActivities[index]['personaRemitente']['apellido1']}',
                                        initialDate: initialDate,
                                        finalDate: finalDate,
                                        subject: subject,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void showNormalActivity(BuildContext context, normalActivityData) {
    Get.bottomSheet(
      showNormalActivityModal(context, normalActivityData),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    ).then((value) {
      _taskStudentController.selectedFilePath.value = '';
      _taskStudentController.filePath.value = File('');
      _taskStudentController.commentController.text = '';
    });
  }

  void showQuestionnaireActivity(
      BuildContext context, questionnaireActivityData) {
    Get.bottomSheet(
      showQuestionnaireActivityModal(context, questionnaireActivityData),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).then((value) {
      _taskStudentController.selectedOption.value = -1;
      _taskStudentController.selectedOptions.clear();
    });
  }

  Widget showNormalActivityModal(BuildContext context, activityData) {
    if (activityData[0]['estado']['estado'] == 'ACTIVO') {
      return Container(
        height: 700,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              listColor[13],
              listColor[11],
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ContSup(),
                const SizedBox(height: 20),
                const Text(
                  'Actividad',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    _buildTableRow('Título:',
                        '${activityData[0]['tituloActividad']}', 16, 12),
                    _buildTableRow('Descripción:',
                        '${activityData[0]['descripcionActividad']}', 16, 12),
                    _buildTableRow(
                        'Asignatura:',
                        '${activityData[0]['materia']['nombreMateria']}',
                        16,
                        12),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Documento',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        _flutterMediaDownloaderPlugin.downloadMedia(
                            context, 'https://www.orimi.com/pdf-test.pdf');
                      },
                      icon: Icon(
                        Icons.downloading,
                        color: listColor[12],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 410,
                  margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: SfPdfViewer.network(
                    enableTextSelection: true,
                    enableDoubleTapZooming: true,
                    enableDocumentLinkAnnotation: true,
                    enableHyperlinkNavigation: true,
                    canShowScrollStatus: true,
                    'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Responder actividad',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          String filePath = result.files.single.path!;
                          _taskStudentController.setSelectedFilePath(filePath);
                          _taskStudentController.setFilePath(file);
                        }
                      },
                      child: const Text('Seleccionar archivo'),
                    ),
                    const SizedBox(width: 5),
                    Obx(() {
                      if (_taskStudentController
                          .selectedFilePath.value.isNotEmpty) {
                        String fileName = path.basename(
                            _taskStudentController.selectedFilePath.value);
                        return Flexible(
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(fileName),
                          ),
                        );
                      } else {
                        return const ElevatedButton(
                          onPressed: null,
                          child: Text('Archivo'),
                        );
                      }
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 18.0, right: 18.0),
                  child: TextField(
                    controller: _taskStudentController.commentController,
                    maxLines: null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: listColor[11],
                      labelText: "Respuesta escrita",
                      hintText: "Respuesta escrita",
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.question_answer_outlined,
                        color: Colors.white,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    String idActividad = activityData[0]
                            ['calificacionActividad']['id']
                        .toString();
                    _taskStudentController.replyActivityP(idActividad);
                  },
                  child: const Text('Enviar evidencia'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return showModalPastActivity('Su actividad');
    }
  }

  Widget showQuestionnaireActivityModal(BuildContext context, activityData) {
    if (activityData['idEstado'] == 1) {
      return Container(
        height: 700,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              listColor[13],
              listColor[11],
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ContSup(),
                const SizedBox(height: 20),
                const Text(
                  'Cuestionario',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    _buildTableRow('Título:',
                        '${activityData['tituloActividad']}', 16, 12),
                    _buildTableRow('Descripción:',
                        '${activityData['descripcionActividad']}', 16, 12),
                    _buildTableRow('Asignatura:',
                        '${activityData['materia']['nombreMateria']}', 16, 12),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    activityData['preguntas'].length,
                    (index) {
                      var question = activityData['preguntas'][index];
                      List<dynamic> options = [];
                      for (var respuesta in question['respuestas']) {
                        options.add(respuesta);
                      }
                      print('coentrao ${question['respuestas']}');
                      if (question['idTipoPregunta'] == 4) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question['descripcion'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  options.length,
                                  (index) => Obx(
                                    () => CheckboxListTile(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return const Color(0xff00C535);
                                          }
                                          return Colors.white;
                                        },
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        options[index]['descripcionRespuesta'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      value: _taskStudentController
                                          .selectedOptions
                                          .contains(index),
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          _taskStudentController
                                              .toggleSelectedOption(index);
                                          var selectedResponseId =
                                              options[index]['id'];
                                          print(selectedResponseId);
                                          print(_taskStudentController
                                              .selectedOptions);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (question['idTipoPregunta'] == 3) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question['descripcion'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  question['respuestas'].length,
                                  (index) => Obx(
                                    () => RadioListTile<int>(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return const Color(0xff00C535);
                                          }
                                          return Colors.white;
                                        },
                                      ),
                                      title: Text(
                                        question['respuestas'][index]['descripcionRespuesta'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      value: question['respuestas'][index]['id'],
                                      groupValue: _taskStudentController
                                          .selectedOption.value,
                                      onChanged: (value) {
                                       _taskStudentController
                                            .setSelectedOption(value!);
                                        var selectedResponseId =
                                            question['respuestas'][index]['id'];
                                        print(
                                            'ID de respuesta seleccionada: $selectedResponseId');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question['descripcion'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Escribe tu respuesta aquí',
                                  hintStyle:
                                      const TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child: const Text('Enviar cuestionario'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return showModalPastActivity('El cuestionario');
    }
  }

  Widget showQuestionnaireActivityModal1(BuildContext context, activityData) {
    if (activityData['idEstado'] == 1) {
      return Container(
        height: 700,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              listColor[13],
              listColor[11],
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ContSup(),
                const SizedBox(height: 20),
                const Text(
                  'Cuestionario',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    _buildTableRow('Título:',
                        '${activityData['tituloActividad']}', 16, 12),
                    _buildTableRow('Descripción:',
                        '${activityData['descripcionActividad']}', 16, 12),
                    _buildTableRow('Asignatura:',
                        '${activityData['materia']['nombreMateria']}', 16, 12),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    activityData['preguntas'].length,
                    (index) {
                      var question = activityData['preguntas'][index];
                      List<String> options = [];

                      for (var respuesta in question['respuestas']) {
                        options.add(respuesta['descripcionRespuesta']);
                      }
                      if (question['idTipoPregunta'] == 3 ||
                          question['idTipoPregunta'] == 4) {
                        return CardQuestions(
                          idTypeQuestion: '${question['idTipoPregunta']}',
                          question: question['descripcion'],
                          options: options,
                          onChanged: (value) {
                            print(options);
                          },
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question['descripcion'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Escribe tu respuesta aquí',
                                  hintStyle:
                                      const TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child: const Text('Enviar cuestionario'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return showModalPastActivity('El cuestionario');
    }
  }

  Widget showModalPastActivity(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            listColor[13],
            listColor[11],
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ContSup(),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Información',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '$name ya paso la fecha de presentación',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, String content, double titleFontSize,
      double contentFontSize) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 3.5),
          child: Text(
            content,
            style: TextStyle(fontSize: contentFontSize, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

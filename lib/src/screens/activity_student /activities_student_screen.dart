import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:flutter_media_downloader/flutter_media_downloader.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/activity_student%20/task_student_controller.dart';
import 'package:vtschool/src/widgets/card_task_student.dart';
import 'package:vtschool/src/widgets/cont_sup.dart';

class ActivitiesStudentScreen extends StatelessWidget {
  final TaskStudentController _taskStudentController =
      Get.put(TaskStudentController());
  final TextEditingController _searchController = TextEditingController();
  final _flutterMediaDownloaderPlugin = MediaDownload();

  ActivitiesStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20),
            height: 50,
            child: const Text(
             'Mis actividades',
             style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
               color: Colors.black,
             ),
                            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 18.0, right: 18.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _taskStudentController.filterActivitiesStudent(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 238, 238, 238),
                hintText: "Buscar",
                hintStyle: const TextStyle(color: Colors.black54),
                prefixIcon: Icon(
                  Icons.search,
                  color: _searchController.text.isNotEmpty
                      ? Colors.black54
                      : Colors.black38,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _searchController.text.isNotEmpty
                        ? Colors.black54
                        : Colors.black38,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0),
              ),
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
             const SizedBox(
            height: 15,
          ),
          Obx(
            () => _taskStudentController.isLoading.value
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : 
                 Expanded(
                     child: RefreshIndicator(
                     onRefresh: _taskStudentController.refreshItems, 
                      child:
                          _taskStudentController.filteredActivitiesStudent.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No tienes actividades',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _taskStudentController
                                      .filteredActivitiesStudent.length,
                                  itemBuilder: ((context, index) {
                                    // String idActividad = _taskStudentController
                                    //     .filteredActivitiesStudent[index]
                                    //         ['idActividad']
                                    //     .toString();
                                    String initialDate = _taskStudentController
                                            .filteredActivitiesStudent[index]
                                        ['fechaInicial'];
                                    String finalDate = _taskStudentController
                                            .filteredActivitiesStudent[index]
                                        ['fechaFinal'];
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_taskStudentController
                                                              .filteredActivitiesStudent[
                                                          index]['actividad']
                                                      ['tipoActividad']
                                                  ['tipoActividad'] ==
                                              'Normal') {
                                           
                                            showNormalActivity(
                                                context,
                                                _taskStudentController
                                                        .filteredActivitiesStudent[
                                                    index]);
                  
                                            print(
                                                'Prueba data: ${_taskStudentController.activitiesById}');
                                          } else {
                                            // await _taskStudentController
                                            //     .getActivityQuestionnaire(
                                            //         idActividad);
                                            showQuestionnaireActivity(
                                                context,
                                                _taskStudentController
                                                        .filteredActivitiesStudent[
                                                    index]);
                                          }
                                        },
                                        child: CardTaskStudent(
                                          idActivity:
                                              '${_taskStudentController.filteredActivitiesStudent[index]['idActividad']}',
                                          affair:
                                              '${_taskStudentController.filteredActivitiesStudent[index]['actividad']['tituloActividad']}',
                                          urlPhotoSender:
                                              '${_taskStudentController.filteredActivitiesStudent[index]['persona']['rutaFoto']}',
                                          nameOfsender:
                                              '${_taskStudentController.filteredActivitiesStudent[index]['persona']['nombre1']} ${_taskStudentController.filteredActivitiesStudent[index]['persona']['apellido1']}',
                                          initialDate: initialDate,
                                          finalDate: finalDate,
                                          subject:
                                              '${_taskStudentController.filteredActivitiesStudent[index]['actividad']['materia']['nombreMateria']}',
                                          status: '${_taskStudentController.filteredActivitiesStudent[index]['estado']['estado']}'
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                    ),
                ),
          ),
        ],
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
      _taskStudentController.selectedOptions.clear();
      _taskStudentController.selectedAnswer.clear();
      _taskStudentController.valuesInputQuestionnaire.clear();
    });
  }

  Widget showNormalActivityModal(BuildContext context, activityData) {
    Color themeColor = Theme.of(context).dialogBackgroundColor;
    print(activityData);
    if (activityData['estado']['estado'] == 'ACTIVO') {
      return Container(
        height: 700,
        decoration: BoxDecoration(
          color: themeColor,
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
                    color: Colors.black,
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
                        '${activityData['actividad']['tituloActividad']}', 16, 12),
                    _buildTableRow('Descripción:',
                        '${activityData['actividad']['descripcionActividad']}', 16, 12),
                    _buildTableRow('Asignatura:',
                        '${activityData['actividad']['materia']['nombreMateria']}', 16, 12),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Documento',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        _flutterMediaDownloaderPlugin.downloadMedia(
                            context, '${activityData['actividad']['DocUrl']}');
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
                    '${activityData['actividad']['DocUrl']}',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Responder actividad',
                  style: TextStyle(color: Colors.black, fontSize: 16),
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
                      fillColor: Colors.grey[200],
                      labelText: "Respuesta escrita",
                      hintText: "Respuesta escrita",
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.question_answer_outlined,
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue,
                  ),
                  onPressed: () async{
                    String idActividad = activityData['id'].toString();
                    await _taskStudentController.replyActivity(idActividad);
                    _taskStudentController.getActivitiesStudent();
                  },
                  child: const Text('Enviar evidencia'),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (activityData['estado']['estado'] == 'ACEPTADO') {
      return showModalPastActivity(context, 'Ya respondio su actividad');
    } else if (activityData['estado']['estado'] == 'CALIFICADO') {
      return showModalPastActivity(
          context, 'Su profesor ya califico su actividad');
    } else {
      //validar con la fecha
      return showModalPastActivity(
          context, 'Se vencio el plazo de su actividad');
    }
  }

  Widget showQuestionnaireActivityModal(BuildContext context, activityData) {
    String idQualification = activityData['id'].toString();
    Color themeColor = Theme.of(context).dialogBackgroundColor;
    if (activityData['estado']['estado'] == 'ACTIVO') {
      return Container(
        height: 700,
        decoration: BoxDecoration(
          color: themeColor,
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
                    color: Colors.black,
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
                    _buildTableRow(
                        'Título:',
                        '${activityData['actividad']['tituloActividad']}',
                        16,
                        12),
                    _buildTableRow(
                        'Descripción:',
                        '${activityData['actividad']['descripcionActividad']}',
                        16,
                        12),
                    _buildTableRow(
                        'Asignatura:',
                        '${activityData['actividad']['materia']['nombreMateria']}',
                        16,
                        12),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    activityData['actividad']['preguntas'].length,
                    (index) {
                      var question =
                          activityData['actividad']['preguntas'][index];
                      final selectedValue = (-1).obs;
                      List<dynamic> options = question['respuestas'];
                      if (question['idTipoPregunta'] == "3") {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              if(question['DocUrl'] != null)
                              Padding(padding: const EdgeInsets.all(10.0),
                              child: Image.network(question['DocUrl'])),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  options.length,
                                  (index) => Obx(
                                    () => RadioListTile<int>(
                                      fillColor: WidgetStateProperty
                                          .resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return const Color(0xff00C535);
                                          }
                                          return Colors.black;
                                        },
                                      ),
                                      title: Text(
                                        options[index]['descripcionRespuesta'],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      value: options[index]['id'],
                                      groupValue: selectedValue.value,
                                      onChanged: (value) {
                                        selectedValue.value = value!;
                                        var selectedResponseId =
                                            options[index]['id'];
                                        var selectedQuestionId = question['id'];
                                        var selectedResponseDescription =
                                            options[index]
                                                ['descripcionRespuesta'];
                                        _taskStudentController.saveAnswers(
                                          idQuestion: selectedQuestionId,
                                          idAnswer: selectedResponseId.toString(),
                                          description: selectedResponseDescription
                                              .toString(),
                                          idTypeQuestion: 3,
                                        );
                                        // (_taskStudentController
                                        //     .selectedAnswer);
                                        ('${_taskStudentController.selectedAnswer}');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        var idQuestion = question['id'];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                               color: Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                                  color: Colors.black,
                                ),
                              ),
                              if(question['DocUrl'] != null)
                              Padding(padding: const EdgeInsets.all(10.0),
                              child: Image.network(question['DocUrl'])),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Escribe tu respuesta aquí',
                                  hintStyle:
                                      const TextStyle(color: Colors.black54),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) {
                                  _taskStudentController.saveAnswers(
                                      valueInput: value, idQuestion: idQuestion, idTypeQuestion: 2);
                                },
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
                  onPressed: () async {
                    if (_taskStudentController.selectedAnswer.isNotEmpty) {
                        await _taskStudentController.replyQuestionnaire(
                            idQualification,
                           );
                      } else {
                        Get.defaultDialog(
                          title: '¡Información!',
                          middleText:
                              'Debes responder por al menos una pregunta',
                          textConfirm: 'OK',
                          onConfirm: () => Get.back(),
                        );
                    }
                    /*List<int> idTypeQuestion = [];
                    var questions = activityData['actividad']['preguntas'];
                    for (var question in questions) {
                      idTypeQuestion.add(question["idTipoPregunta"]);
                    }
                    if (idTypeQuestion.contains(1) ||
                        idTypeQuestion.contains(3) &&
                            idTypeQuestion.contains(4)) {
                      if (_taskStudentController
                              .valuesInputQuestionnaire.isNotEmpty ||
                          _taskStudentController.selectedAnswer.isNotEmpty) {
                        await _taskStudentController.replyQuestionnaire1(
                            idQualification, showModalInfoAnswer(context));
                        await _taskStudentController
                            .replyQuestionnaire(idQualification);
                      } else {
                        Get.defaultDialog(
                          title: '¡Información!',
                          middleText:
                              'Debes responder por al menos una pregunta',
                          textConfirm: 'OK',
                          onConfirm: () => Get.back(),
                        );
                      }
                    } else {
                      if (_taskStudentController.selectedAnswer.isNotEmpty) {
                        await _taskStudentController.replyQuestionnaire(
                            idQualification,
                            alert: showModalQualification(context));
                      } else {
                        Get.defaultDialog(
                          title: '¡Información!',
                          middleText:
                              'Debes responder por al menos una pregunta',
                          textConfirm: 'OK',
                          onConfirm: () => Get.back(),
                        );
                      }
                    }**/
                    _taskStudentController.reiniciarRespuestas();
                    _taskStudentController.getActivitiesStudent();
                  },
                  child: const Text('Enviar cuestionario'),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (activityData['estado']['estado'] == 'PENDIENTE') {
      return showModalPastActivity(context, 'El cuestionario ya no esta disponible');
    } else if (activityData['estado']['estado'] == 'CALIFICADO') {
      return showModalPastActivity(
          context, 'Su profesor ya califico su cuestionario');
    } else {
      //validar con la fecha
      return showModalPastActivity(
          context, 'Se vencio el plazo de su cuestionario');
    }
  }

  Widget showModalPastActivity(BuildContext context, String title) {
    Color themeColor = Theme.of(context).dialogBackgroundColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      height: 400,
      decoration: BoxDecoration(
        color: themeColor,
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
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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

  Widget showModalInfoAnswer(BuildContext context) {
    Color themeColor = Theme.of(context).dialogBackgroundColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      height: 400,
      decoration: BoxDecoration(
        color: themeColor,
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
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              '¡Debes estar pendiente, el \n profesor enviará la nota final!',
              style: TextStyle(
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

  Widget showModalQualification(BuildContext context) {
    return Obx(() {
      List<dynamic> respuestas =
          _taskStudentController.answerRating['respuestas'];
      int allQuestion =
          _taskStudentController.activityQuestionnaire['preguntas'].length;
      int successes = _taskStudentController.answerRating['cantidad_aciertos'];
      String qualification =
          _taskStudentController.answerRating['puntaje_total'];
      double percentage = (successes * 100 / allQuestion);
      Color themeColor = Theme.of(context).dialogBackgroundColor;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        height: 600,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ContSup(),
            const SizedBox(height: 20),
            const Text(
              'Respuestas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: respuestas.length,
                itemBuilder: (context, index) {
                  final respuesta = respuestas[index];
                  final dynamic incorrecta = respuesta['incorrectas'];
                  return Card(
                    color: listColor[10],
                    child: ListTile(
                      title: Text(
                        'Pregunta: ${respuesta['enunciado']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: incorrecta == null
                              ? Colors.greenAccent[700]
                              : Colors.red[700],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (incorrecta != null)
                            Text(
                              'Su respuesta: ${respuesta['proporcionada']}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          Text(
                            'Respuesta correcta: ${respuesta['correcta']}',
                            style: TextStyle(
                              color: incorrecta == null
                                  ? Colors.black
                                  : Colors.red[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Calificacion final: $qualification',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
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
                  ),
                ),
                Text(
                  'Cantidad de aciertos: $successes de $allQuestion ($percentage%)',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
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
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 3.5),
          child: Text(
            content,
            style: TextStyle(fontSize: contentFontSize, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

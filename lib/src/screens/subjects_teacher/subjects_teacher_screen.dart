import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/calendar/calendar_controller.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';
import 'package:vtschool/src/screens/subjects_teacher/subjects_teacher_controller.dart';
import 'package:vtschool/src/widgets/card_subject_teacher.dart';

class SubjectsTeacherScreen extends StatelessWidget {
  SubjectsTeacherScreen({super.key});
  final TextEditingController _searchController = TextEditingController();
  final ChatController _chatController = Get.put(ChatController());
  final ProfileUserController profileUserController =
      Get.put(ProfileUserController());
  final CalendarController1 _calendarController =
      Get.put(CalendarController1());
  final SubjectsTeacherController _subjectsTeacherController =
      Get.put(SubjectsTeacherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Asignaturas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
                  _chatController.filterUsers(value);
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
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
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
              height: 25,
            ),
            Obx(
              () => _chatController.isLoading.value
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: _chatController.filteredUsers.isNotEmpty
                          ? const Center(
                              child: Text(
                                'No tienes materias',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 0.8,
                              ), 
                              itemCount: _calendarController.events.length,
                              itemBuilder: (context, index) {
                                return CardSubjectTeacher(
                                  nameSubject:
                                      '${_calendarController.events[index]["materia"]["materia"]["nombreMateria"]}',
                                  workingDay:
                                      '${_calendarController.events[index]["asignacionPeriodoProgramaJornada"]["jornada"]["nombreJornada"]}',
                                  program:
                                      '${_calendarController.events[index]["materia"]["grado"]["programa"]["nombrePrograma"]}',
                                  color: getRandomColor(),
                                  onTap: () async {
                                    await _subjectsTeacherController.getSubject(
                                        _calendarController.events[index][
                                                "asignacionPeriodoProgramaJornada"]
                                            ["idJornada"].toString(),
                                        _calendarController.events[index][
                                                "materia"]["idMateria"].toString(),
                                        _calendarController.events[index][
                                                "asignacionPeriodoProgramaJornada"]
                                            ["asignacion_periodo_programa"]["idPrograma"].toString(),
                                          _calendarController.events[index][
                                                "horaInicial"],
                                        _calendarController.events[index][
                                                "horaFinal"],
                                        _calendarController.events[index]["id"]);
                                    Get.toNamed('/subject_teacher');
                                  },
                                  onTapCalendar: () {
                                    Get.toNamed('/activities_teacher');
                                  },
                                );
                              }),
                    ),
            ),
          ])),
    );
  }
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

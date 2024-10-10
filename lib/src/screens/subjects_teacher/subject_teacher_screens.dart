import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';
import 'package:vtschool/src/screens/subjects_teacher/subjects_teacher_controller.dart';
import 'package:vtschool/src/widgets/drop_down_menu_item.dart';

class SubjectTeacherScreen extends StatelessWidget {
  SubjectTeacherScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final SubjectsTeacherController _subjectsTeacherController =
      Get.put(SubjectsTeacherController());
  final ActivitiesTeacherController _activitiesTeacherController =
      Get.put(ActivitiesTeacherController());
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(bottom: 30.0, top: 20.0),
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButton2(
                    isExpanded: true,
                    customButton: const Icon(
                      Icons.menu_rounded,
                      size: 34,
                      color: Color(0xFFB8BCBD),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      offset: const Offset(-20, 0),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14, top: 5),
                    ),
                    items: [
                      customDropdownMenuItem(
                          context,
                          'Gestión de actividades',
                          true,
                          1,
                          () async{
                            _activitiesTeacherController.getActivitiesById('${_subjectsTeacherController.subject[0]['horario'][0]["materia"]
                                 ["materia"]['id']}');
                            await Future.delayed(const Duration(seconds: 1), (){
                              Get.toNamed('/activities_teacher');
                            });
                          } 
                        ),

                         customDropdownMenuItem(
                          context,
                          'Actividades asignadas',
                          true,
                          2,
                          () async{
                            _activitiesTeacherController.getActivitiesByTeacher('${_subjectsTeacherController.subject[0]['horario'][0]["materia"]
                                 ["materia"]['id']}');
                            await Future.delayed(const Duration(seconds: 1), (){
                              Get.toNamed('/assigned_activities');
                            });
                          } 
                        ),
                        customDropdownMenuItem(
                          context,
                          'Salir',
                          true,
                          3,
                          () {
                            _subjectsTeacherController.subject.value = [];
                             Get.back();
                          },
                         ),
                          customDropdownMenuItem(
                          context,
                          'Maquetado',
                          true,
                          4,
                          () async{
                        
                            await Future.delayed(const Duration(seconds: 1), (){
                              Get.toNamed('/rate_activities');
                            });
                          } 
                        ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 18.0,
                right: 18.0,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  //_chatController.filterUsers(value);
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color(0xFFB8BCBD),
                        size: 40,
                      ),
                      Text(
                        '${_subjectsTeacherController.subject[0]['matriculas'].length}',
                        style: const TextStyle(
                            fontSize: 22, color: Color(0xFFB8BCBD)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Estudiantes',
                    style:
                        TextStyle(fontSize: 20, color: Color(0xFFB8BCBD)),
                  ),
                ]),
                // const SizedBox(
                //   width: 30,
                // ),
                // Obx(() {
                //   return Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(
                //         width: 40,
                //         height: 40,
                //         child: Stack(
                //           fit: StackFit.expand,
                //           children: [
                //             Container(
                //               decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 border: Border.all(
                //                   color: Colors.blueAccent,
                //                   width: 8,
                //                 ),
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(4.0),
                //               child: CircularProgressIndicator(
                //                 value: _subjectsTeacherController.progress,
                //                 strokeWidth: 6,
                //                 backgroundColor: Colors.grey[300],
                //                 valueColor: const AlwaysStoppedAnimation<Color>(
                //                     Colors.blue),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Center(
                //         child: Text(
                //           '${_subjectsTeacherController.timeElapsed.value}s',
                //           style: const TextStyle(fontSize: 24),
                //         ),
                //       ),
                //     ],
                //   );
                // }),
              ],
            ),
            // TextButton(
            //   child: const Text("Start"),
            //   onPressed: () => _subjectsTeacherController.startTimer(),
            // ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: 370,
                    decoration: BoxDecoration(
                      color: const Color(0xFF313E68),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              _subjectsTeacherController.subject[0]['horario']
                                  [0]["contrato"]["persona"]["rutaFoto"],
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_subjectsTeacherController.subject[0]['horario'][0]["contrato"]["persona"]["nombre1"]} ${_subjectsTeacherController.subject[0]['horario'][0]["contrato"]["persona"]?["nombre2"] ?? ''} ${_subjectsTeacherController.subject[0]['horario'][0]["contrato"]["persona"]["apellido1"]} ${_subjectsTeacherController.subject[0]['horario'][0]["contrato"]["persona"]?["nombre2"] ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  _subjectsTeacherController.subject[0]
                                          ['horario'][0]["materia"]["materia"]
                                      ["nombreMateria"],
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '${_subjectsTeacherController.subject[0]['matriculas'].length} estudiantes',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.library_books_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                //),
              ],
            ),
            Expanded(
                child: _subjectsTeacherController.subject.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay estudiantes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(25),
                        itemCount: _subjectsTeacherController
                            .subject[0]['matriculas'].length,
                        itemBuilder: (BuildContext context, int index) {
                          final student = _subjectsTeacherController.subject[0]
                              ['matriculas'][index];
                          final person = student['matricula']['persona'];
                          final users = _subjectsTeacherController.subject[0]
                              ['matriculas'][index];
                          Color getRandomColor() {
                            if (student["notaFinal"] >= 4.6) {
                              return const Color(0xFF749E60);
                            } else if (student["notaFinal"] >= 4.0 &&
                                student["notaFinal"] < 4.6) {
                              return const Color(0xFF7ECD57);
                            } else if (student["notaFinal"] > 3.0 &&
                                student["notaFinal"] < 4.0) {
                              return const Color(0xFFF44E1A);
                            } else {
                              return const Color(0xFFD63A3A);
                            }
                          }

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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(person["rutaFoto"]),
                                          radius: 25,
                                          backgroundColor: const Color.fromARGB(
                                              255, 236, 199, 199),
                                        ),
                                        Flexible(
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 200),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${person["nombre1"]} ${person["apellido1"]}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${_subjectsTeacherController.subject[0]['horario'][0]["materia"]["materia"]["nombreMateria"]}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Padre: ${student['acudiente']?['nombre1'] ?? 'Sin'} ${student['acudiente']?['apellido1'] ?? 'acudiente'}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${student["notaFinal"]}',
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
                                            Obx(() => Checkbox(
                                                  value:
                                                      _subjectsTeacherController
                                                          .checkboxes[index],
                                                  onChanged: (bool? value) {
                                                    _subjectsTeacherController
                                                        .toggleCheckbox(
                                                            index, value!);
                                                  },
                                                  activeColor: Colors.white,
                                                  checkColor: Colors.black,
                                                )),
                                            IconButton(
                                              onPressed: () async {
                                                _chatController.onConnectPressed(
                                                    '${student['matricula']!['idPersona']}');
                                                _chatController.getMessage(
                                                    '${student['matricula']!['idPersona']}');
                                                _chatController
                                                    .setSelectedUser(users);
                                                Get.toNamed('/chat');
                                              },
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
                        })),
          ])),
    );
  }
}

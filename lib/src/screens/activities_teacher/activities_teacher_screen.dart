import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';
import 'package:vtschool/src/screens/subjects_teacher/subjects_teacher_controller.dart';

class ActivitiesTeacherScreen extends StatelessWidget {
  final ActivitiesTeacherController _activitiesTeacherController =
      Get.put(ActivitiesTeacherController());
  final TextEditingController _searchController = TextEditingController();
  ActivitiesTeacherScreen({super.key});
    final SubjectsTeacherController _subjectsTeacherController =
      Get.put(SubjectsTeacherController());

  Future<void> _refreshData() async {
    _activitiesTeacherController.getActivitiesById(
      '${_subjectsTeacherController.subject[0]['horario'][0]["materia"]
        ["materia"]['id']}'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 80,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Text(
                    'Actividades creadas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
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
                  _activitiesTeacherController.filterActivities(value);
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: Obx(() {
                  if (_activitiesTeacherController.activities1.isEmpty) {
                    return const Center(child: Text('No hay actividades'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: _activitiesTeacherController.activities1.length,
                    itemBuilder: (context, index) {
                      var activity =
                          _activitiesTeacherController.activities1[index];
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(
                                color: const Color.fromARGB(255, 172, 172, 172),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    // leading: Image.network(activity.docUrl),
                                    title: Text(activity.tituloActividad),
                                    subtitle: Text(activity.descripcionActividad),
                                  ),
                                ),
                                const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.delete_forever_rounded),
                                    Icon(Icons.book_outlined),
                                    Icon(Icons.add),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10), // Espacio entre ítems
                        ],
                      );
                    },
                  );
                }),
              ),
            ),
          ])),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 1,
            child: FloatingActionButton(
              onPressed: () => Get.toNamed('/new_activity_teacher'),
              heroTag: 'btn2',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

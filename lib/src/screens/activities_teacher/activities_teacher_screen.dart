import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';

class ActivitiesTeacherScreen extends StatelessWidget {
  final ActivitiesTeacherController _activitiesTeacherController =
      Get.put(ActivitiesTeacherController());
  final TextEditingController _searchController = TextEditingController();
  ActivitiesTeacherScreen({super.key});

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
            /*Obx(
              () => _activitiesTeacherController.isLoading.value
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: _activitiesTeacherController
                              .activities1.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes actividades',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : ListView.builder(
          itemCount: _activitiesTeacherController.activities1.length,
          itemBuilder: (context, index) {
            var activity = _activitiesTeacherController.activities1[index];
            return Card(
              child: ListTile(
               // leading: Image.network(activity.docUrl),
                title: Text(activity.tituloActividad),
                subtitle: Text(activity.descripcionActividad),
              ),
            );
          },
        )
      ),
    

            ),*/
             Obx(() {
        if (_activitiesTeacherController.activities1.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: ListView.builder(
            itemCount: _activitiesTeacherController.activities1.length,
            itemBuilder: (context, index) {
              var activity = _activitiesTeacherController.activities1[index];
              return Card(
                child: ListTile(
                 // leading: Image.network(activity.docUrl),
                  title: Text(activity.tituloActividad),
                  subtitle: Text(activity.descripcionActividad),
                ),
              );
            },
          ),
        );
      }),
          ])),
    );
  }
}

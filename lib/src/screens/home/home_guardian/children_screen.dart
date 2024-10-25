import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/home/home_guardian/children_controller.dart';
import 'package:vtschool/src/screens/logout/logout_screen.dart';
import 'package:vtschool/src/widgets/card_chats.dart';

class ChildrenScreen extends StatelessWidget {
  final ChildrenController _childrenController = Get.put(ChildrenController());
  ChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  //logoutApp(context);
                  Get.toNamed('/login');
                },
              ),
              const Text(
                'ESTUDIANTES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(25),
                    itemCount: _childrenController.childrenList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: 370,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white60,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _childrenController.childrenList[index].estudiante.rutaFoto),
                                        radius: 25,
                                        backgroundColor:
                                            const Color.fromARGB(255, 236, 199, 199),
                                      ),
                                      const SizedBox(
                                        width: 20,
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
                                                '${_childrenController.childrenList[index].estudiante.nombre1} ${_childrenController.childrenList[index].estudiante.nombre2} ${_childrenController.childrenList[index].estudiante.apellido1} ${_childrenController.childrenList[index].estudiante.apellido2}',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}

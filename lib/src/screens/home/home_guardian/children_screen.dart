import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/logout/logout_screen.dart';
import 'package:vtschool/src/widgets/card_chats.dart';

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({super.key});

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
                'HIJOS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Obx(
              //   () => 
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(25),
                    itemCount: 1,
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
        offset: Offset(3, 3),
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
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://chisellabs.com/glossary/wp-content/uploads/2023/05/962b45f9-e2a6-4f59-8f0a-9e1e1a1d1f7f.png'),
                                        radius: 25,
                                        backgroundColor: Color.fromARGB(
                                            255, 236, 199, 199),
                                      ),
                                      const SizedBox(width: 20,),
                                      Flexible(
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 200),
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ADRIAN MOLINA VELASCO',
                                                style: TextStyle(
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
             // ),
            ])),
      ),
    );
  }
}

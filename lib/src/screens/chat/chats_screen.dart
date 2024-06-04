import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';
import 'package:vtschool/src/widgets/card_chats.dart';
import 'package:vtschool/src/widgets/cont_sup.dart';
import 'package:vtschool/src/widgets/loading.dart';

class Chats extends StatelessWidget {
  Chats({super.key});
  final TextEditingController _searchController = TextEditingController();
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_chatController.isLoading.value) {
        return const LoadingScreen();
      } else {
        return Container(
            padding: const EdgeInsets.only(bottom: 80),
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
            child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                'Chats',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: listColor[10],
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 7.0),
                  ),
                  style: TextStyle(
                    color: listColor[10],
                  ),
                ),
              ),
              Expanded(
                child: _chatController.filteredUsers.isEmpty
                    ? const Center(
                        child: Text(
                          'No tienes chats',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(25),
                        itemCount: _chatController.filteredUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final users = _chatController.filteredUsers[index];
                          return GestureDetector(
                            onTap: () async {
                              _chatController.onConnectPressed(
                                  '${users['matricula']!['persona']['id']}');
                               _chatController.getMessage(
                                  '${users['matricula']!['persona']['id']}');
                              _chatController.setSelectedUser(users);
                            
                              Get.toNamed('/chat');
                            },
                            onLongPress: () {
                              showOptionsModal();
                            },
                            child: CardChats(
                              urlPhotoSender: users['matricula']!['persona']
                                  ['rutaFoto'],
                              name: users['matricula']!['persona']['nombre1'],
                              lastName: users['matricula']!['persona']
                                  ['apellido1'],
                              endMessage: users['matricula']!['persona']
                                  ['email'],
                            ),
                          );
                        },
                      ),
              ),
            ]));
      }
    });
  }

  void showOptionsModal() {
    Get.bottomSheet(
      optionsModal(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  Widget optionsModal() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            listColor[11],
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
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(
                left: 18,
              ),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Archivar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 18, top: 30, bottom: 30),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 18, bottom: 30),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Center(
                    child: Text(
                      'Marcar como leido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Abrir chat',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

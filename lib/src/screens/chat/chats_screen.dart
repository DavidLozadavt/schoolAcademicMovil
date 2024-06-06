import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';
import 'package:vtschool/src/widgets/card_chats.dart';
import 'package:vtschool/src/widgets/loading.dart';

class Chats extends StatelessWidget {
  Chats({super.key});
  final TextEditingController _searchController = TextEditingController();
  final ChatController _chatController = Get.put(ChatController());
  final ProfileUserController profileUserController =
      Get.put(ProfileUserController());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_chatController.isLoading.value) {
        return const LoadingScreen();
      } else {
        return Padding(
            padding: const EdgeInsets.only(bottom: 80),
           
            child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Chats',
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
              Expanded(
                child: _chatController.filteredUsers.isEmpty
                    ? const Center(
                        child: Text(
                          'No tienes chats',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(25),
                        itemCount: _chatController.filteredUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final users = _chatController.filteredUsers[index];
                          if(profileUserController.userProfile['persona']['id'] != users['matricula']!['persona']['id']){
                            return GestureDetector(
                            onTap: () async {
                              _chatController.onConnectPressed(
                                  '${users['matricula']!['persona']['id']}');
                               _chatController.getMessage(
                                  '${users['matricula']!['persona']['id']}');
                              _chatController.setSelectedUser(users);
                            
                              Get.toNamed('/chat');
                            },
                            /*onLongPress: () {
                              showOptionsModal();
                            },*/
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
                          }else{
                            return const Spacer();
                          }
                          
                        },
                      ),
              ),
            ]));
      }
    });
  }

 /* void showOptionsModal() {
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
  }*/
}

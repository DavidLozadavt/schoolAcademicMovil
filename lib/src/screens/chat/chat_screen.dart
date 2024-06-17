import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';

class Chat extends StatelessWidget {
  Chat({super.key});
  final TextEditingController _searchController = TextEditingController();
  final ChatController _chatController = Get.put(ChatController());
  final ProfileUserController profileUserController =
      Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    final selectedUser = _chatController.selectedUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: listColor[12],
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                _chatController.disconnected();
                _chatController.clearDataMessage();
                _chatController.keyboard.value = false;
                _chatController.clearSelectedFilePath();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 300,
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${selectedUser['matricula']!['persona']['rutaFoto']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${selectedUser['matricula']!['persona']['rutaFoto']}'),
                  backgroundColor: Colors.transparent),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${selectedUser['matricula']!['persona']['nombre1']} ${selectedUser['matricula']!['persona']['apellido1']}'),
                Text(
                  '${selectedUser['matricula']!['persona']['email']}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fondo_chat.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: Column(
          children: [
            Obx(() {
              var messages = _chatController.messages;
              messages.sort((a, b) => b['id']!.compareTo(a['id']!));
              if (messages.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime dateTime =
                          DateTime.parse(messages[index]['created_at']);
                      String formattedDate =
                          DateFormat('dd MMMM yyyy', 'es').format(dateTime);
                      bool isOwnMessage = messages[index]
                              ['idActivationCompanyUser'] !=
                          selectedUser['matricula']['persona']['id'].toString();
                      debugPrint('$messages');
                      dynamic archivos = messages[index]['archivos'];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: isOwnMessage
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (messages[index]['idActivationCompanyUser'] ==
                                selectedUser['matricula']['persona']['id']
                                    .toString())
                              CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    '${selectedUser['matricula']!['persona']['rutaFoto']}',
                                  ),
                                  backgroundColor: Colors.transparent),
                            const SizedBox(width: 8.0),
                            Flexible(
                              child: Card(
                                elevation: 4,
                                color: isOwnMessage
                                    ? Colors.blue[100]
                                    : Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (archivos.isNotEmpty)
                                        Column(
                                          children:
                                              archivos.map<Widget>((archivo) {
                                            String archivoUrl =
                                                archivo['archivo'];
                                            String extension =
                                                archivoUrl.split('.').last;
                                            String fileName =
                                                path.basename(archivoUrl);
                                            if (['jpg', 'jpeg', 'png', 'gif']
                                                .contains(
                                                    extension.toLowerCase())) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox(
                                                                  width: 300,
                                                                  height: 400,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    child: Image
                                                                        .network(
                                                                      archivoUrl,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    _chatController
                                                                        .saveFileFromUrl(
                                                                            archivoUrl);
                                                                  },
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          'Descargar imagen'),
                                                                      Icon(Icons
                                                                          .download_rounded),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Image.network(
                                                    archivoUrl,
                                                    width: 300,
                                                    height: 300,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              );
                                            } else if (['pdf'].contains(
                                                extension.toLowerCase())) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: "Mensaje",
                                                      content: Text(
                                                          "¿Desea descargar el archivo $fileName?"),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            _chatController
                                                                .saveFileFromUrl(
                                                                    archivoUrl);
                                                            Get.back();
                                                          },
                                                          child:
                                                              const Text("Si"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons
                                                              .picture_as_pdf_outlined,
                                                          color: Colors.red,
                                                          size: 30.0),
                                                      const SizedBox(
                                                          width: 8.0),
                                                      Expanded(
                                                        child: Text(fileName,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else if (['xls', 'xlsx'].contains(
                                                extension.toLowerCase())) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: "Mensaje",
                                                      content: Text(
                                                          "¿Desea descargar el archivo $fileName?"),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            _chatController
                                                                .saveFileFromUrl(
                                                                    archivoUrl);
                                                            Get.back();
                                                          },
                                                          child:
                                                              const Text("Si"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.grid_on,
                                                          color: Colors.green,
                                                          size: 30.0),
                                                      const SizedBox(
                                                          width: 8.0),
                                                      Expanded(
                                                        child: Text(fileName,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .green)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: "Mensaje",
                                                      content: Text(
                                                          "¿Desea descargar el archivo $fileName?"),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            _chatController
                                                                .saveFileFromUrl(
                                                                    archivoUrl);
                                                            Get.back();
                                                          },
                                                          child:
                                                              const Text("Si"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons
                                                              .file_present_rounded,
                                                          color: Colors.grey,
                                                          size: 30.0),
                                                      const SizedBox(
                                                          width: 8.0),
                                                      Expanded(
                                                        child: Text(fileName,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .blue)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          }).toList(),
                                        ),
                                      Text('${messages[index]['body']}',
                                          style: kTlightpromin),
                                      Text(formattedDate,
                                          style: kTlightpromin2),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (messages[index]['idActivationCompanyUser'] !=
                                selectedUser['matricula']['persona']['id']
                                    .toString())
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${profileUserController.userProfile['persona']?['rutaFoto']}'),
                                backgroundColor: Colors.transparent,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: Text('No tienes mensajes'),
                  ),
                );
              }
            }),
            Container(
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (_chatController.selectedFilePath.value.isNotEmpty) {
                      String extension = _chatController.selectedFilePath.value
                          .split('.')
                          .last;
                      String fileName =
                          path.basename(_chatController.selectedFilePath.value);
                      if (['jpg', 'jpeg', 'png', 'gif']
                          .contains(extension.toLowerCase())) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(_chatController.selectedFilePath.value),
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      } else if (['pdf'].contains(extension.toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.picture_as_pdf_outlined,
                                  color: Colors.red, size: 30.0),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(fileName,
                                    style: const TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      } else if (['xls', 'xlsx']
                          .contains(extension.toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.grid_on,
                                  color: Colors.green, size: 30.0),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(fileName,
                                    style:
                                        const TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.file_present_rounded,
                                  color: Colors.blue, size: 30.0),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(fileName,
                                    style: const TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onTap: () {
                              _chatController.keyboard.value = false;
                            },
                            controller: _chatController.messageController,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {},
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: listColor[10],
                              hintText: "Mensaje",
                              hintStyle: TextStyle(color: listColor[14]),
                              prefixIcon: const SizedBox.shrink(),
                              suffixIcon: IconButton(
                                icon: Icon(_chatController.keyboard.value
                                    ? Icons.keyboard
                                    : Icons.add_outlined),
                                onPressed: () {
                                  if (_chatController.keyboard.value == false) {
                                    _chatController.keyboard.value = true;
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    FocusScope.of(context).requestFocus();
                                    _chatController.keyboard.value = false;
                                  }
                                },
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
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (_chatController
                                  .messageController.text.isNotEmpty) {
                                await _chatController.sendMessage(
                                    '${selectedUser['matricula']!['persona']['id']}');
                                _chatController.messageController.clear();
                                _chatController.clearSelectedFilePath();
                                var jsonMessage =
                                    json.encode(_chatController.postMessage);
                                _chatController.onTriggerEventPressed(
                                    '${selectedUser['matricula']!['persona']['id']}',
                                    jsonMessage);
                              } else {
                                Get.snackbar(
                                    '¡Error!', 'El mensaje esta vacio');
                              }
                            },
                            icon: const Icon(Icons.send)),
                      ],
                    ),
                  ),
                  if (_chatController.keyboard.value)
                    Container(
                      height: 300,
                      color: Colors.white60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                    source: ImageSource.camera);

                                if (pickedFile != null) {
                                  File file = File(pickedFile.path);
                                  String filePath = pickedFile.path;
                                  _chatController.setSelectedFilePath(filePath);
                                  _chatController.setFilePath(file);
                                } else {
                                  debugPrint('No se selecciono nunguna imagen');
                                  //print('No se seleccionó ninguna imagen');
                                }
                              },
                              icon: const Icon(Icons.camera_alt_outlined)),
                          IconButton(
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  File file = File(pickedFile.path);
                                  String filePath = pickedFile.path;
                                  _chatController.setSelectedFilePath(filePath);
                                  _chatController.setFilePath(file);
                                } else {
                                  //print('No se seleccionó ninguna imagen');
                                  debugPrint('No se seleccionó ninguna imagen');
                                }
                              },
                              icon: const Icon(Icons.photo_library_outlined)),
                          IconButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  File file = File(result.files.single.path!);
                                  String filePath = result.files.single.path!;
                                  _chatController.setSelectedFilePath(filePath);
                                  _chatController.setFilePath(file);
                                } else {
                                  debugPrint('No se seleccionó ningun archivo');
                                }
                              },
                              icon: const Icon(Icons.attach_file)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

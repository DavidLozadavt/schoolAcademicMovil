import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/fonts_styles.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';

class Chat extends StatelessWidget {
  Chat({super.key});
  final TextEditingController _searchController = TextEditingController();
  final mensajes = false;

  final ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: listColor[12],
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://phantom-marca.unidadeditorial.es/c56848cfee85df94876073904cfdd799/resize/660/f/webp/assets/multimedia/imagenes/2022/07/30/16591778851898.jpg'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cristiano Ronaldo'),
                Text(
                  'Futbolista',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.more_vert),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://media.istockphoto.com/id/1218737747/es/vector/aprender-en-l%C3%ADnea-chat-de-videollamadas-de-e-learning-con-clase-educaci%C3%B3n-a-distancia.jpg?s=2048x2048&w=is&k=20&c=mkHKSpauHrMUfDUxOwOv0VlEPHpOcqvmiYeOfjGAULE='),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Container(
              alignment:
                  mensajes ? Alignment.centerLeft : Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  Card(
                    elevation: 1,
                    color: listColor[12],
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hooola compaÑero', style: kTlightpromin),
                          //const SizedBox(height: 8),
                          Text('02-05-2024', style: kTlightpromin2),
                        ],
                      ),
                    ),
                  ),
                  
                  Card(
                    elevation: 1,
                    color: listColor[12],
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Como estas?', style: kTlightpromin),
                          //const SizedBox(height: 8),
                          Text('02-05-2024', style: kTlightpromin2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
               
              child: Container(
                alignment:
                    mensajes ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Card(
                      elevation: 1,
                      color: listColor[11].withOpacity(0.5),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hola', style: kTlightpromin),
                            //const SizedBox(height: 8),
                            Text('02-05-2024', style: kTlightpromin2),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: listColor[12],
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muy bien', style: kTlightpromin),
                            //const SizedBox(height: 8),
                            Text('02-05-2024', style: kTlightpromin2),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: listColor[12],
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('y tu?', style: kTlightpromin),
                            //const SizedBox(height: 8),
                            Text('02-05-2024', style: kTlightpromin2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: chatController.textFieldFocus,
                      controller: chatController.textFieldController,
                      onChanged: (value) {},
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: listColor[10],
                        hintText: "Mensaje",
                        hintStyle: TextStyle(color: listColor[14]),
                        prefixIcon: IconButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());

                            chatController.toggleEmojiShowing();
                          },
                          icon: const Icon(Icons.emoji_emotions_outlined),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.ads_click),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              onPressed: () {},
                            ),
                          ],
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            ),
            Obx(() => Offstage(
                  offstage: !chatController.emojiShowing.value,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      chatController.addEmoji(emoji.emoji);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

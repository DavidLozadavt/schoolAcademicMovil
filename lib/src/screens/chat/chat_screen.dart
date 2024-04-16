import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';

class Chat extends StatelessWidget {
  Chat({super.key});
  final TextEditingController _searchController = TextEditingController();
 
  final ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                Text('Futbolista', style: TextStyle(
                    fontSize: 12
                ),),
              ],
            ),
            Spacer(),
            Icon(Icons.more_vert), 
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: listColor[11].withOpacity(0.1)),
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: chatController.textFieldFocus,
                      controller: chatController.textFieldController,
                      onChanged: (value) {},
                      keyboardType: TextInputType
                          .multiline,
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
                          icon: Icon(Icons.emoji_emotions_outlined),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.ads_click),
                              onPressed: () {
                               
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.camera_alt_outlined),
                              onPressed: () {
                              
                              },
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.send))
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

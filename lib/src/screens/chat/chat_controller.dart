import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var emojiShowing = false.obs;
  var textFieldController = TextEditingController();
    var textFieldFocus = FocusNode();

  void toggleEmojiShowing() {
    emojiShowing.value = !emojiShowing.value;
     if (emojiShowing.value) {
      FocusScope.of(Get.context!).requestFocus(textFieldFocus);
    }
  }

  void addEmoji(String emoji) {
  final text = textFieldController.text;
  final selection = textFieldController.selection;
  
  if (selection.start >= 0 && selection.end >= 0 && selection.end >= selection.start) {
    final newText = text.substring(0, selection.start) +
        emoji +
        text.substring(selection.end);
    textFieldController.text = newText;
    textFieldController.selection = TextSelection.fromPosition(
      TextPosition(offset: selection.start + emoji.length),
    );
  }
}


}

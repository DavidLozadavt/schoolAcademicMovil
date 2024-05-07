import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/chat_provider.dart';

class ChatController extends GetxController {
  final ChatProvider _chatProvider = ChatProvider();
  var emojiShowing = false.obs;
  var textFieldController = TextEditingController();
  var textFieldFocus = FocusNode();
  var isLoading = true.obs;
  var users = <Map<String, dynamic>>[].obs;
   var filteredUsers = <Map<String, dynamic>>[].obs;

  void toggleEmojiShowing() {
    emojiShowing.value = !emojiShowing.value;
    if (emojiShowing.value) {
      FocusScope.of(Get.context!).requestFocus(textFieldFocus);
    }
  }

  void addEmoji(String emoji) {
    final text = textFieldController.text;
    final selection = textFieldController.selection;

    if (selection.start >= 0 &&
        selection.end >= 0 &&
        selection.end >= selection.start) {
      final newText = text.substring(0, selection.start) +
          emoji +
          text.substring(selection.end);
      textFieldController.text = newText;
      textFieldController.selection = TextSelection.fromPosition(
        TextPosition(offset: selection.start + emoji.length),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    isLoading(true);
    try {
      await _chatProvider.getUsersByUser();
      users.assignAll(_chatProvider.users);
      filteredUsers.assignAll(users);
      print('11111111222 $users');
    } catch (error) {
      //print('Error fetching events: $error');
    } finally {
       isLoading(false);
    }
  }

   void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(users.where((user) {
        final String name = user['matricula']!['persona']['nombre1'].toString().toLowerCase();
        final String lastName = user['matricula']!['persona']['apellido1'].toString().toLowerCase();
        final String email =
            user['matricula']!['persona']['email'].toString().toLowerCase();
        final String identifications =
            user['matricula']!['persona']['identificacion'].toString().toLowerCase();
        return name.contains(query.toLowerCase()) ||
            lastName.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase()) ||
            identifications.contains(query.toLowerCase());
      }));
    }
  }
}

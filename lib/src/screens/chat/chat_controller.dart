import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/providers/chat_provider.dart';

class ChatController extends GetxController {
  final ChatProvider _chatProvider = ChatProvider();
  var keyboard = false.obs;
  var messageController = TextEditingController();
  var isLoading = true.obs;
  var users = <Map<String, dynamic>>[].obs;
  var filteredUsers = <Map<String, dynamic>>[].obs;
  var messages = <Map<String, dynamic>>[].obs;
  final _selectedUser = {}.obs;
  var postMessage = {}.obs;
  RxString selectedFilePath = ''.obs;
  Rx<File> filePath = Rx<File>(File(''));
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final log = ''.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  /*void jumpToEnd() {
   if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }*/

  Future<void> getUsers() async {
    try {
      await _chatProvider.getUsersByUser();
      users.assignAll(_chatProvider.users);
      filteredUsers.assignAll(users);
      isLoading(true);
    } catch (error) {
      //('Error: $error');
      ('Error: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getMessage(String idUserSelected) async {
    try {
      await _chatProvider.getMessage(idUserSelected);
      messages.assignAll(_chatProvider.messages);
    } catch (error) {
      // ('Error: $error');
      ('Error: $error');
    } finally {
      isLoading(false);
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(users.where((user) {
        final String name =
            user['matricula']!['persona']['nombre1'].toString().toLowerCase();
        final String lastName =
            user['matricula']!['persona']['apellido1'].toString().toLowerCase();
        final String email =
            user['matricula']!['persona']['email'].toString().toLowerCase();
        final String identifications = user['matricula']!['persona']
                ['identificacion']
            .toString()
            .toLowerCase();
        return name.contains(query.toLowerCase()) ||
            lastName.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase()) ||
            identifications.contains(query.toLowerCase());
      }));
    }
  }

  void setSelectedUser(dynamic user) {
    _selectedUser.value = user;
  }

  get selectedUser => _selectedUser;

  void clearDataMessage() {
    messages.clear();
  }

  void logMessage(String text) {
    ("LOG: $text");
    //("LOG: $text");
    log.value += "$text\n";
  }

  void onConnectPressed(String idUserSelected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myIdUser = prefs.getString('idUser') ?? '';
    try {
      await pusher.init(
        apiKey: '850de022339c4d609a8f',
        cluster: 'us2',
        authEndpoint: pusherUrl,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        onAuthorizer: onAuthorizer,
      );
      await pusher.connect();
      final intMyIdUser = int.parse(myIdUser.toString());
      final intIdUserSelected = int.parse(idUserSelected.toString());
      final chatChannelName =
          'private-chat-one-to-one-${intMyIdUser < intIdUserSelected ? intMyIdUser : intIdUserSelected}-${intMyIdUser > intIdUserSelected ? intMyIdUser : intIdUserSelected}';
      await pusher.subscribe(channelName: chatChannelName);
    } catch (e) {
      //('Error: $e');
      ('Error: $e');
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    logMessage("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    logMessage("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    var jsonMessage = json.decode(event.data);
    messages.add(jsonMessage);
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    logMessage("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    logMessage("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    logMessage("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    logMessage("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    logMessage("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    logMessage("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    logMessage(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  String generateHmacSHA256(String data, String key) {
    final hmacSha256 = Hmac(sha256, utf8.encode(key));
    final digest = hmacSha256.convert(utf8.encode(data));
    return digest.toString();
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    const secret = "b7ec85147f0fb7b9846c";
    final stringToSign = "$socketId:$channelName";
    final signature = generateHmacSHA256(stringToSign, secret);
    return {
      "auth": "850de022339c4d609a8f:$signature",
    };
  }

  void onTriggerEventPressed(String idUserSelected, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myIdUser = prefs.getString('idUser') ?? '';
    final intMyIdUser = int.parse(myIdUser.toString());
    final intIdUserSelected = int.parse(idUserSelected.toString());
    final chatChannelName =
        'private-chat-one-to-one-${intMyIdUser < intIdUserSelected ? intMyIdUser : intIdUserSelected}-${intMyIdUser > intIdUserSelected ? intMyIdUser : intIdUserSelected}';
    // (data);
    pusher.trigger(PusherEvent(
        channelName: chatChannelName,
        eventName: 'client-chat-one-to-one',
        data: data));
  }

  void disconnected() async {
    await pusher.disconnect();
  }

  Future<void> sendMessage(String idUserSelected) async {
    try {
      final responseMessage = await _chatProvider.sendMessage(
          idUserSelected, messageController.text, [filePath.value]);
      var jsonString = json.encode(responseMessage);
      var jsonMessage = json.decode(jsonString);
      messages.add(jsonMessage);
      postMessage(jsonMessage);
      /* if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      jumpToEnd();
    }*/
    } catch (e) {
      //('Error: $e');
      ('Error: $e');
    }
  }

  void setSelectedFilePath(String path) {
    selectedFilePath.value = path;
  }

  void setFilePath(File path) {
    filePath.value = path;
  }

  void clearSelectedFilePath() {
    selectedFilePath.value = '';
    filePath.value = File('');
  }

  Future<void> saveFileFromUrl(String url) async {
    if (await Permission.storage.request().isGranted) {
      try {
        Directory? directory = await getExternalStorageDirectory();
        if (directory != null) {
          List<String> urlSegments = url.split('/');
          String fileName = urlSegments.last;
          var response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            File file = File('${directory.path}/$fileName');
            await file.writeAsBytes(response.bodyBytes);
            Get.snackbar(
              'Éxito',
              'Archivo guardado',
            );
          } else {
            Get.snackbar(
              '¡Error!',
              'No se pudo descargar el archivo',
            );
          }
        } else {
          Get.snackbar(
              'Error', 'No se pudo obtener el directorio de almacenamiento');
        }
      } catch (e) {
        Get.snackbar('Error', 'Ocurrió un error al guardar el archivo');
      }
    } else {
      Get.snackbar('Error', 'No se concedieron permisos de almacenamiento');
    }
  }
}

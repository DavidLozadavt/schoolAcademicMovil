/*import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/screens/chat/chat_controller.dart';

class PusherController extends GetxController {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final ChatController chatController = ChatController();
  final log = ''.obs;

  void logMessage(String text) {
    print("LOG: $text");
    log.value += text + "\n";
  }

  void onConnectPressed(String idUserSelected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myIdUser = prefs.getString('idUser') ?? '';
    try {
      await pusher.init(
        apiKey: '850de022339c4d609a8f',
        cluster: 'us2',
        authEndpoint: 'http://192.168.1.101:8000/api/auth/pusher',
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
      print('9999999999 $e');
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    logMessage("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    logMessage("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    logMessage("onEvent: $event");
    chatController.messages.add(event.data);
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

  void onTriggerEventPressed(String idUserSelected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myIdUser = prefs.getString('idUser') ?? '';
    final intMyIdUser = int.parse(myIdUser.toString());
    final intIdUserSelected = int.parse(idUserSelected.toString());
    final chatChannelName =
        'private-chat-one-to-one-${intMyIdUser < intIdUserSelected ? intMyIdUser : intIdUserSelected}-${intMyIdUser > intIdUserSelected ? intMyIdUser : intIdUserSelected}';
    pusher.trigger(PusherEvent(
        channelName: chatChannelName,
        eventName: 'client-chat',
        data: 'Prueba'));
  }

  void disconnected() async {
    await pusher.disconnect();
  }
}
*/
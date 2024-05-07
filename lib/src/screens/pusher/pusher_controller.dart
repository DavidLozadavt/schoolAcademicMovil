import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PusherController extends GetxController {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final log = ''.obs;
  final apiKey = TextEditingController();
  final cluster = TextEditingController();
  final channelName = TextEditingController();
  final eventName = TextEditingController();
  final channelFormKey = GlobalKey<FormState>();
  final eventFormKey = GlobalKey<FormState>();
  final listViewController = ScrollController();
  final data = TextEditingController();

  void logMessage(String text) {
    print("LOG: $text");
    log.value += text + "\n";
    Future.delayed(
      Duration(milliseconds: 100),
      () => listViewController.jumpTo(listViewController.position.maxScrollExtent),
    );
  }

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }

  void initPlatformState() async {
    if (!GetPlatform.isAndroid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      apiKey.text = prefs.getString("apiKey") ?? '';
      cluster.text = prefs.getString("cluster") ?? 'eu';
      channelName.text = prefs.getString("channelName") ?? 'my-channel';
      eventName.text = prefs.getString("eventName") ?? 'client-event';
      data.text = prefs.getString("data") ?? 'test';
    }
  }

  void onConnectPressed() async {
    if (!channelFormKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("apiKey", apiKey.text);
    prefs.setString("cluster", cluster.text);
    prefs.setString("channelName", channelName.text);

    try {
      await pusher.init(
        apiKey: apiKey.text,
        cluster: cluster.text,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
      );
      await pusher.subscribe(channelName: channelName.text);
      await pusher.connect();
    } catch (e) {
      logMessage("ERROR: $e");
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
    logMessage("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "foo:bar",
      "channel_data": '{"user_id": 1}',
      "shared_secret": "foobar"
    };
  }

  void onTriggerEventPressed() async {
    var eventFormValidated = eventFormKey.currentState!.validate();

    if (!eventFormValidated) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("eventName", eventName.text);
    prefs.setString("data", data.text);
    pusher.trigger(PusherEvent(
        channelName: channelName.text,
        eventName: eventName.text,
        data: data.text));
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/auth_provider.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';


class PushNotificationProvider {
  final ProfileUserController profileController = Get.put(ProfileUserController());
  
  final AuthProvider authProvider = AuthProvider();
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description:
        'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await _firebaseMessaging.requestPermission();
    final fCMToken =  await _firebaseMessaging.getToken();
    print('tokenAppDevice $fCMToken');
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token_device', fCMToken.toString());
    initPushNotications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future initPushNotications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

   void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    profileController.incrementNotificationCount();
    if (notification != null && android != null && !kIsWeb) {
     flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
            groupKey: 'test',
            setAsGroupSummary: true,
          ),
        ),
      );
    }
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/providers/push_notification_provider.dart';
import 'package:vtschool/src/screens/home/home_admin/home_admin.dart';
import 'package:vtschool/src/screens/home/home_student/home_student.dart';
import 'package:vtschool/src/screens/activity/task_student_screen.dart';
import 'package:vtschool/src/screens/notification/notification_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
import 'package:vtschool/src/screens/starting/starting_page.dart';
import 'package:vtschool/src/screens/auth/login_screen.dart';
import 'package:vtschool/src/screens/home/home_teacher/home_teacher.dart';
import 'package:vtschool/src/screens/starting/starting_screen.dart';
import 'package:vtschool/src/screens/wompi/card_credit.dart';
import 'package:vtschool/src/screens/wompi/wompi_servise.dart';
import 'package:vtschool/src/utils/firebase_options.dart';


PushNotificationProvider pushNotificationProvider = PushNotificationProvider();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await pushNotificationProvider.initNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    //pushNotificationProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme(selectedColor: 11).getTheme(),
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
       initialRoute: '/starting_init_screen',
      getPages: [
        GetPage(name: '/starting_init_screen', page: () => StartingInitScreen()),
        GetPage(name: '/starting', page: () => const StartingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home_student', page: () => const HomeStudent()),
        GetPage(name: '/home_teacher', page: () => const HomeTeacher()),
        GetPage(name: '/home_admin', page: () => const HomeAdmin()),
        GetPage(name: '/profile_view', page: () => ProfileUserScreen()),
        GetPage(name: '/banner', page: () => const PagosPage()),
        GetPage(name: '/creditCart', page: () => const MySample()),
        GetPage(name: '/notification', page: () => NotificationScreen()),
        GetPage(name: '/task_student', page: () => TaskStudentScreen()),
      ],
     
    );
  }
}

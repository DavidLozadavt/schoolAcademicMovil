import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/providers/push_notification_provider.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_screen.dart';
import 'package:vtschool/src/screens/chat/chat_screen.dart';
import 'package:vtschool/src/screens/home/home_admin/home_admin.dart';
import 'package:vtschool/src/screens/home/home_student/home_student.dart';
import 'package:vtschool/src/screens/activity_student%20/task_student_screen.dart';
import 'package:vtschool/src/screens/notification/notification_screen.dart';
import 'package:vtschool/src/screens/payments/form_payments_screen.dart';
import 'package:vtschool/src/screens/payments/tuition_payments/physical_tuition_payments_screen.dart';
import 'package:vtschool/src/screens/payments/registration_payment/payment_transaction_registration_screen.dart';
import 'package:vtschool/src/screens/payments/payments_screen.dart';
import 'package:vtschool/src/screens/payments/registration_payment/physical_registration_payment_screen.dart';
import 'package:vtschool/src/screens/payments/pse_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
import 'package:vtschool/src/screens/starting/starting_page.dart';
import 'package:vtschool/src/screens/auth/login_screen.dart';
import 'package:vtschool/src/screens/home/home_teacher/home_teacher.dart';
import 'package:vtschool/src/screens/starting/starting_screen.dart';
import 'package:vtschool/src/screens/subjects_teacher/subject_teacher_screens.dart';
import 'package:vtschool/src/utils/firebase_options.dart';

import 'src/screens/payments/tuition_payments/tuition_payments _transaction_screen.dart';

PushNotificationProvider pushNotificationProvider = PushNotificationProvider();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
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
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      initialRoute: '/starting_init_screen',
      getPages: [
        GetPage(
            name: '/starting_init_screen', page: () => StartingInitScreen()),
        GetPage(name: '/starting', page: () => const StartingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home_student', page: () => HomeStudent()),
        GetPage(name: '/home_teacher', page: () => HomeTeacher()),
        GetPage(name: '/home_admin', page: () => HomeAdmin()),
        GetPage(name: '/profile_view', page: () => ProfileUserScreen()),
        GetPage(name: '/notification', page: () => NotificationScreen()),
        GetPage(name: '/task_student', page: () => TaskStudentScreen()),
        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/payments', page: () => PaymentsScreen()),
        GetPage(name: '/physical_registration_payment', page: () => PhysicalRegistrationPaymentScreen()),
        GetPage(name: '/payment_transaction_registration', page: () => PaymentTransactionRegistrationScreen()),
        GetPage(name: '/tuition_payments_transaction', page: () => TuitionPaymentsTransactionScreen()),
        GetPage(name: '/physical_tuition_payments', page: () => PhysicalTuitionPaymentsScreen()),
        GetPage(name: '/pse', page: () => PseScreen()),
        GetPage(name: '/form_payments_transaction', page: () => FormPaymentsScreen()),
        GetPage(name: '/subject_teacher', page: ()=> SubjectTeacherScreen()),
        GetPage(name: '/activities_teacher', page: () => ActivitiesTeacherScreen())
      ],
    );
  }
}

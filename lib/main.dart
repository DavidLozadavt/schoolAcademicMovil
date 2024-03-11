import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/provider/theme_dark_or_light.dart';
import 'package:vtschool/src/screens/home/home_admin/home_admin.dart';
import 'package:vtschool/src/screens/home/home_student/home_student.dart';
import 'package:vtschool/src/screens/starting/starting_page.dart';
import 'package:vtschool/src/screens/auth/login_screen.dart';
import 'package:vtschool/src/screens/home/home_teacher/home_teacher.dart';
import 'package:vtschool/src/screens/profile/myprofile_screen.dart';
import 'package:vtschool/src/screens/profile/update_profile_screen.dart';
import 'package:vtschool/src/screens/starting/starting_screen.dart';
import 'package:vtschool/src/screens/wompi/card_credit.dart';
import 'package:vtschool/src/screens/wompi/wompi_servise.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = ref.watch(isDarkmodeProvider);
    return GetMaterialApp(
      theme: AppTheme(selectedColor: 3, isDarkMode: isDarkmode).getTheme(),
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
       initialRoute: '/starting_init_screen',
      getPages: [
        GetPage(name: '/starting_init_screen', page: () => StartingInitScreen()),
        GetPage(name: '/starting', page: () => StartingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home_student', page: () => const HomeStudent()),
        GetPage(name: '/home_teacher', page: () => const HomeTeacher()),
        GetPage(name: '/home_admin', page: () => const HomeAdmin()),
        GetPage(name: '/profile_view', page: () => const MyProfileScreen()),
        GetPage(name: '/update_profile', page: () => const UpdateProfileScreen()),
        GetPage(name: '/banner', page: () => const PagosPage()),
        GetPage(name: '/creditCart', page: () => const MySample()),
        
        
      ],
     
    );
  }
}

  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:vtschool/src/config/theme/app_theme.dart';
  import 'package:vtschool/src/provider/theme_dark_or_light.dart';
  import 'package:get/get.dart';
  import 'package:vtschool/src/screens/auth/Start_loading_screen.dart';
  import 'package:vtschool/src/screens/auth/Starting_page.dart';
  import 'package:vtschool/src/screens/auth/loginNew.dart';
  import 'package:vtschool/src/screens/auth/login_screen.dart';
  import 'package:vtschool/src/screens/auth/register_screen.dart';
  import 'package:vtschool/src/screens/inicio/home_screen.dart';
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
        getPages: [
          GetPage(name: '/loading', page: () => const LoadingScreen()),
          GetPage(name: '/starting', page: () => const StartingScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => const RegisterScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          GetPage(name: '/profile_view', page: () => const MyProfileScreen()),
          GetPage(name: '/update_profile', page: () => const UpdateProfileScreen()),
          GetPage(name: '/banner', page: () =>  const PagosPage()),
          GetPage(name: '/creditCart', page: () =>  const MySample()),
          GetPage(name: '/loginnew', page: () =>  const LoginNew()),
          GetPage(name: '/startingPrueba', page: () => StartingPage()),
        ],
        initialRoute: '/startingPrueba',
      );
    }
  }
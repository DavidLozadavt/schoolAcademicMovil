import 'package:go_router/go_router.dart';
import 'package:vtschool/Src/Screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/loading',
  routes: [
    GoRoute(
        path: '/loading', builder: (context, state) => const LoadingScreen()),
    GoRoute(
        path: '/starting', builder: (context, state) => const StartingScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: '/register', builder: (context, state) => const RegisterScreen()),
   
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/profile_view',
        builder: (context, state) => const MyProfileScreen()),

   
    // GoRoute(
    //     path: '/update_profile',
    //     builder: (context, state) => const UpdateProfileScreen()),
  ],
);

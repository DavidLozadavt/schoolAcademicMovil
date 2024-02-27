import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vtschool/Src/Screens/profile/data_prueba.dart';
import 'package:vtschool/Src/Screens/profile/update_profile_screen.dart';
import '../profile/myprofile_screen.dart';
import 'principal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const PrincipalScreen(),
    const MyProfileScreen(),
    UpdateProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 25,
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 247, 233, 106),
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white.withOpacity(1.0),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(LineIcons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.user),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.database),
          label: 'Datos',
        ),
      ],
    );
  }
}

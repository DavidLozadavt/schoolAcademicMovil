// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/Src/Config/fonts_styles.dart';
import 'package:vtschool/Src/Controllers/perfil_controller.dart';
import 'package:vtschool/Src/Models/student.dart';
import 'package:vtschool/Src/Models/user_profile_model.dart';
import 'package:vtschool/Src/Screens/Calendar/calendar_screen.dart';
import 'package:vtschool/Src/Screens/notas/Student_notas.dart';
import 'package:vtschool/Src/Screens/notas/Task.dart';
import 'package:vtschool/Src/Screens/profile/logout_screen.dart';
import 'package:vtschool/Src/Screens/wompi/pay_screen.dart';
import 'package:vtschool/Src/Screens/wompi/wompi_servise.dart';
import 'package:vtschool/Src/Widgets/custom_alert.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen>
    with SingleTickerProviderStateMixin {
  UserData? userProfile;
  bool isLoading = true;
  final ProfileController _profileController = ProfileController();
  late TabController _tabController;

  List<Task> tasks = [
    Task('Examen de Calculo', 'Revisar apuntes de Calculo'),
    Task('Taller de Ingles', 'Revisar apuntes de  Ingles'),
    Task('Tarea de Informatica', 'Revisar apuntes Informatica'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    Future.delayed(
      const Duration(seconds: 2),
      () {
        showDialogPay();
        _profileController.fetchAndSetProfileData(getProfileData);
      },
    );
  }

  void getProfileData(UserData? profile, bool loading) {
    setState(() {
      userProfile = profile;
    });
  }

  void _showInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PagosPage();
      },
    );
  }

  void showDialogPay() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: 'Hola!!!',
          subtitle: ' Recuerde que su pensión  esta vencida.',
          imagePath: 'assets/images/Warning.png',
          color: Color(0xFFFFC502),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFFFC502),
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFFC502),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: const Color(0xFFFFC502),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    '${userProfile?.userData.persona.nombre1} ${userProfile?.userData.persona.apellido1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    '${userProfile?.userData.email}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('pagos'),
              leading: const Icon(Icons.wallet_rounded),
              onTap: () {
                Get.toNamed('/banner');
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Get.back();
                logoutApp(context);
              },
            ),
           
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          if (userProfile == null)
                            const CupertinoActivityIndicator(
                              radius:
                                  15.0, // Puedes ajustar el tamaño según tus preferencias
                            )
                          else
                            Text(
                              '${userProfile?.userData.persona.nombre1} ${userProfile?.userData.persona.apellido1}',
                              style: kTitleStylew,
                            ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/avatar.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TabBarWidget(tabController: _tabController),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        Calendar(),
                      ],
                    ),
                  ),
                  userProfile != null
                      ? const StudentPage()
                      : const Center(child: CircularProgressIndicator()),
                  // You need to create UserDataWidget and pass userProfile
                  userProfile != null
                      ? TaskScreen(tasks)
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  PagosPage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        dividerColor: Colors.white,
        controller: _tabController,
        tabs: const [
          Tab(text: 'Agenda'),
          Tab(text: 'Mis notas'),
          Tab(text: 'Mis tareas'),
          Tab(text: 'Pagos'),
        ],
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: kTlight,
        unselectedLabelStyle: kTlight);
  }
}

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';
// import 'package:vtschool/src/widgets/drop_down_menu_item.dart';

// class SubjectsTeacherScreen extends StatelessWidget {
//   final ActivitiesTeacherController _activitiesTeacherController =
//       Get.put(ActivitiesTeacherController());
//   SubjectsTeacherScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//           padding: const EdgeInsets.only(bottom: 80),
//           child: Column(children: [
//             const SizedBox(
//               height: 25,
//             ),
//             Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(right: 20),
//                 child: DropdownButton2(
//                   underline: Container(),
//                   isExpanded: true,
//                   customButton: const Icon(
//                     Icons.more_vert,
//                     size: 34,
//                     color: Colors.black,
//                   ),
//                   dropdownStyleData: DropdownStyleData(
//                     width: 165,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     offset: const Offset(-20, 0),
//                     scrollbarTheme: ScrollbarThemeData(
//                       radius: const Radius.circular(40),
//                       thickness: MaterialStateProperty.all<double>(6),
//                       thumbVisibility: MaterialStateProperty.all<bool>(true),
//                     ),
//                   ),
//                   menuItemStyleData: const MenuItemStyleData(
//                     height: 40,
//                     padding: EdgeInsets.only(left: 14, right: 14, top: 5),
//                   ),
//                   items: [
//                     /* _itemPopUpMenu(context, 'Editar perfil', true, 1,
//                             () => Get.to(() => const PagosPage())),*/
//                     /*_itemPopUpMenu(context, 'Términos y condiciones', true,
//                             3, () => Get.to(const PagosPage())),*/
//                     customDropdownMenuItem(
//                         text: 'Salir',
//                         enabled: true,
//                         value: 1,
//                         onTap: () => Get.back()),
//                   ],
//                   onChanged: (value) {},
//                 ),
//               ),
//             ],
//           ),
//             const Text(
//               'Materias',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Obx(
//               () => _activitiesTeacherController.isLoading.value
//                   ? const Expanded(
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     )
//                   : Expanded(
//                       child: _activitiesTeacherController.filteredActivities.isEmpty
//                           ? const Center(
//                               child: Text(
//                                 'No tienes materias',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             )
//                           : Container(),
//                     ),
//             ),
//           ])),
//     );
//   }
// }
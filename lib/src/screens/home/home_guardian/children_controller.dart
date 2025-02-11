import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/models/auth_user_model.dart';

class ChildrenController extends GetxController {
  var childrenList = <Children>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChildren();
  }

  Future<void> loadChildren() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? childrenJsonList = prefs.getStringList('children');

    if (childrenJsonList != null) {
      childrenList.value = childrenJsonList
          .map((childJson) => Children.fromJson(json.decode(childJson)))
          .toList();
    }
  }

  //saveIdEstudentSelect(String idEstudiante) {}
Future<void> saveIdStudentSelect(String idStudentSelected) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('idUser', idStudentSelected);
  }

 
}


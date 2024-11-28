import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';

class UpdateProfileController extends GetConnect {
  final ProfileUserController _profileController =
      Get.put(ProfileUserController());
  var profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final descriptionController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastName1Controller = TextEditingController();
  final lastName2Controller = TextEditingController();
  final dateController = TextEditingController();
  final idTypeController = TextEditingController();
  final idNumberController = TextEditingController();
  final mobileController = TextEditingController();
  final genderController = TextEditingController();
  final bloodTypeController = TextEditingController();
  final birthDepartmentController = TextEditingController();
  final birthCityController = TextEditingController();
  final locationDepartmentController = TextEditingController();
  final locationCityController = TextEditingController();
  final addressController = TextEditingController();
  final landlineController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
     descriptionController.text = _profileController.userProfile['persona']?['perfil'] ?? '';
     firstNameController.text  = _profileController.userProfile['persona']?['nombre1'] ?? '';
     middleNameController.text  = _profileController.userProfile['persona']?['nombre2'] ?? '';
     lastName1Controller.text  = _profileController.userProfile['persona']?['apellido1'] ?? '';
     lastName2Controller.text  = _profileController.userProfile['persona']?['apellido2'] ?? '';
     dateController.text  = _profileController.userProfile['persona']?['fechaNac'] ?? '';
    // idTypeController.text  = ;
     idNumberController.text  = _profileController.userProfile['persona']?['identificacion'] ?? '';
     mobileController.text  = _profileController.userProfile['persona']?['celular'] ?? '';
    // genderController.text  = ;
     //bloodTypeController.text  = ;
    // birthDepartmentController.text  = ;
   //  birthCityController.text  = ;
   //  locationDepartmentController.text  = ;
   //  locationCityController.text  = ;
     addressController.text  = _profileController.userProfile['persona']?['direccion'] ?? '';
     landlineController.text  = _profileController.userProfile['persona']?['telefonoFijo'] ?? '';
     emailController.text  = _profileController.userProfile['persona']?['email'] ?? '';
  }

  Future<void> pickImage(ImageSource source) async {
    final status = await _requestPermission(source);

    if (status) {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } else {
      Get.snackbar(
        "Permiso denegado",
        "No tienes permiso para acceder a ${source == ImageSource.camera ? "la cámara" : "la galería"}",
      );
    }
  }

  Future<bool> _requestPermission(ImageSource source) async {
    Permission permission;

    if (source == ImageSource.camera) {
      permission = Permission.camera;
    } else {
      permission = Permission.storage;
      if (GetPlatform.isIOS) {
        permission = Permission.photos;
      }
    }

    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result.isGranted;
    }
  }
}

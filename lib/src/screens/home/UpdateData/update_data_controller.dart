import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class UpdateStudentDataController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final AuthProvider authProvider = AuthProvider();
  var userProfile = {}.obs;

  var isLoading = false.obs;
  var currentStep = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      final userData = await authProvider.getProfile();
      userProfile(userData);

      nameController.text = userProfile['persona']['nombre1'] + ' ' +
      userProfile['persona']['apellido1'];
      phoneController.text = userProfile['persona']['celular'] ?? '';

    } finally {
      isLoading(false);
    }
  }

  void saveStudentData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar(
        '¡Datos guardados!', 'Tus datos se han actualizado correctamente');
    Get.offAllNamed('/home_student');
  }

  // Avanzar al siguiente paso
  void nextStep() {
    if (currentStep.value < 1) {
      currentStep.value += 1;
    } else {
      saveStudentData();  // Guardar datos cuando se finalizan todos los pasos
    }
  }

  // Volver al paso anterior
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value -= 1;
    }
  }
}

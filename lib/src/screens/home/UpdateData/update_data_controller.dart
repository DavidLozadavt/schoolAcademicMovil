import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/auth_provider.dart';
import 'package:vtschool/src/providers/citys_provider.dart'; // Importa el proveedor

class UpdateStudentDataController extends GetxController {
  TextEditingController nameOneController = TextEditingController();
  TextEditingController nameTwoController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController lastName2Controller = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController identificacionController = TextEditingController();
  TextEditingController fechaNacController = TextEditingController();
  TextEditingController phonefijeController = TextEditingController();

  final AuthProvider authProvider = AuthProvider();
  final CitysProvider citysProvider = CitysProvider(); // Proveedor de ciudades

  var userProfile = {}.obs;
  var isLoading = false.obs;
  var currentStep = 0.obs;
  var isLoadingCiudades = false.obs;

  var departamentos = [].obs;
  var ciudades = [].obs;
  var selectedDepartamento = ''.obs;
  var selectedCiudad = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
    fetchDepartamentos();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      final userData = await authProvider.getProfile();
      userProfile(userData);

      nameOneController.text = userProfile['persona']['nombre1'] ?? '';
      lastNameController.text = userProfile['persona']['apellido1'] ?? '';
      nameTwoController.text = userProfile['persona']['nombre2'] ?? '';
      lastName2Controller.text = userProfile['persona']['apellido2'] ?? '';
      lastName2Controller.text = userProfile['persona']['apellido2'] ?? '';
      phonefijeController.text = userProfile['persona']['telefonoFijo'] ?? '';
      phoneController.text = userProfile['persona']['celular'] ?? '';
      addressController.text = userProfile['persona']['direccion'] ?? '';
      emailController.text = userProfile['persona']['email'] ?? '';
      identificacionController.text =
          userProfile['persona']['identificacion'] ?? '';
      fechaNacController.text = userProfile['persona']['fechaNac'] ?? '';

      selectedDepartamento.value =
          userProfile['persona']['ciudad_nac']['idDepartamento'].toString();
      selectedCiudad.value =
          userProfile['persona']['ciudad_nac']['id'].toString();
      await fetchCityes(selectedDepartamento.value);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchDepartamentos() async {
    try {
      final response = await citysProvider.getDepartaments();
      departamentos.value = response;
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los departamentos');
    }
  }

  // Obtener ciudades basadas en el departamento seleccionado
  Future<void> fetchCityes(String idDepartamento) async {
    try {
      isLoadingCiudades.value = true;

      final response = await citysProvider
          .getCityes(idDepartamento); // Pasa el idDepartamento a la función
      ciudades.value = response; // Llenar la lista de ciudades
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las ciudades');
    } finally {
      // Finalizar el estado de carga
      isLoadingCiudades.value = false;
    }
  }

  Map<String, dynamic> buildStudentData() {
    return {
      'persona': {
        'nombre1': nameOneController.text,
        'nombre2': nameTwoController.text,
        'apellido1': lastNameController.text,
        'apellido2': lastName2Controller.text,
        'telefono': phoneController.text,
        'telefonoFijo': phonefijeController.text,
        'direccion': addressController.text,
        'email': emailController.text,
        'identificacion': identificacionController.text,
        'fechaNac': fechaNacController.text,
      },
    };
  }

  void saveStudentData() async {
    isLoading.value = true;
    final studentData = buildStudentData();
    String jsonStudentData = jsonEncode(studentData);

    print('Datos del estudiante que se enviarán al backend: $jsonStudentData');

    final response = await authProvider.updateDataUser(studentData);

    if (response != null) {
      Get.snackbar('¡Datos actualizado!', 'Inicial sesión nuevamente');
      Get.offAllNamed('/login');
    } else {
      // Si hubo algún error
      Get.snackbar('Error',
          'No se pudo actualizar los datos del estudiante. Intenta de nuevo más tarde.');
    }

    isLoading.value = false;
  }

  // Avanzar al siguiente paso
  void nextStep() {
    if (currentStep.value < 1) {
      currentStep.value += 1;
    } else {
      saveStudentData();
    }
  }

  // Volver al paso anterior
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value -= 1;
    }
  }
}

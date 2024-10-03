import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/auth_provider.dart';
import 'package:vtschool/src/providers/citys_provider.dart'; // Asegúrate de importar tu proveedor de ciudades

class UpdateStudentDataController extends GetxController {
  TextEditingController nameOneController = TextEditingController();
  TextEditingController nameTwoController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController identificacionController = TextEditingController();
  TextEditingController fechaNacController = TextEditingController();
  TextEditingController ciudadNacController = TextEditingController();
  
  final AuthProvider authProvider = AuthProvider();
  final CitysProvider citysProvider = CitysProvider(); // Instancia de CitysProvider

  var userProfile = {}.obs;
  var isLoading = false.obs;
  var currentStep = 0.obs;

  var departamentos = [].obs; // Lista de departamentos
  var municipios = [].obs; // Lista de municipios
  var selectedDepartamento = ''.obs; // Departamento seleccionado
  var selectedMunicipio = ''.obs; // Municipio seleccionado

  @override
  void onInit() {
    super.onInit();
    fetchEvents(); // Cargar perfil del usuario
    fetchDepartamentos(); // Cargar departamentos
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      final userData = await authProvider.getProfile();
      userProfile(userData);

      nameOneController.text = userProfile['persona']['nombre1'] ?? '';
      lastNameController.text = userProfile['persona']['apellido1'] ?? '';
      nameTwoController.text = userProfile['persona']['nombre2'] ?? '';
      phoneController.text = userProfile['persona']['celular'] ?? '';
      addressController.text = userProfile['persona']['direccion'] ?? '';
      emailController.text = userProfile['persona']['email'] ?? '';
      identificacionController.text = userProfile['persona']['identificacion'] ?? '';
      fechaNacController.text = userProfile['persona']['fechaNac'] ?? '';
      ciudadNacController.text = userProfile['persona']['ciudad_nac']['descripcion'] ?? '';

      selectedMunicipio.value = userProfile['persona']['ciudad_ubicacion']['descripcion'] ?? '';
    } finally {
      isLoading(false);
    }
  }

  // Método para obtener departamentos
  Future<void> fetchDepartamentos() async {
    try {
      isLoading(true);
      final deptos = await citysProvider.getDepartamentos();
      departamentos(deptos);
    } finally {
      isLoading(false);
    }
  }

  // Método para obtener municipios según el departamento seleccionado
  Future<void> fetchMunicipios(String departamentoId) async {
    try {
      isLoading(true);
      final cities = await citysProvider.getMunicipios(departamentoId);
      municipios(cities);
    } finally {
      isLoading(false);
    }
  }

  // Guardar los datos del estudiante
  void saveStudentData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // Simulación de guardado en el backend

    isLoading.value = false;

    Get.snackbar(
        '¡Datos guardados!', 'Tus datos se han actualizado correctamente');
    // Get.offAllNamed('/home_student');
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

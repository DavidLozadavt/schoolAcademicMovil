import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vtschool/src/providers/citys_provider.dart';
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
  CitiesProvider citiesProvider = CitiesProvider();
  var isLoadingCities = false.obs;
  var isLoadingCities2 = false.obs;
  var departments = [].obs;
  var cities = [].obs;
  var cities2 = [].obs;
  var selectedDepartment = ''.obs;
  var selectedCity = ''.obs;

  var selectedDepartment2 = ''.obs;
  var selectedCity2 = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchDepartments();
    descriptionController.text =
        _profileController.userProfile['persona']?['perfil'] ?? '';
    firstNameController.text =
        _profileController.userProfile['persona']?['nombre1'] ?? '';
    middleNameController.text =
        _profileController.userProfile['persona']?['nombre2'] ?? '';
    lastName1Controller.text =
        _profileController.userProfile['persona']?['apellido1'] ?? '';
    lastName2Controller.text =
        _profileController.userProfile['persona']?['apellido2'] ?? '';
    dateController.text =
        _profileController.userProfile['persona']?['fechaNac'] ?? '';
    // idTypeController.text  = ;
    idNumberController.text =
        _profileController.userProfile['persona']?['identificacion'] ?? '';
    mobileController.text =
        _profileController.userProfile['persona']?['celular'] ?? '';
    // genderController.text  = ;
    //bloodTypeController.text  = ;
    // birthDepartmentController.text  = ;
    //  birthCityController.text  = ;
    //  locationDepartmentController.text  = ;
    //  locationCityController.text  = ;
    addressController.text =
        _profileController.userProfile['persona']?['direccion'] ?? '';
    landlineController.text =
        _profileController.userProfile['persona']?['telefonoFijo'] ?? '';
    emailController.text =
        _profileController.userProfile['persona']?['email'] ?? '';
    selectedDepartment.value = _profileController.userProfile['persona']
            ['ciudad_nac']['idDepartamento']
        .toString();
    selectedCity.value = _profileController.userProfile['persona']['ciudad_nac']
            ['id']
        .toString();
    selectedDepartment2.value = _profileController.userProfile['persona']
            ['ciudad_ubicacion']['idDepartamento']
        .toString();
    selectedCity2.value = _profileController.userProfile['persona']
            ['ciudad_ubicacion']['id']
        .toString();
    selectedIdentificationType.value = _profileController.userProfile['persona']
            ['idTipoIdentificacion']
        .toString();
    selectedRH.value = _profileController.userProfile['persona']['rh'];
    selectedGender.value = _profileController.userProfile['persona']['sexo'];
    await fetchCities(selectedDepartment.value);
    await fetchCities2(selectedDepartment2.value);
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

  Future<void> fetchDepartments() async {
    try {
      final response = await citiesProvider.getDepartments();
      departments.value = response;
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los departamentos');
    }
  }

  Future<void> fetchCities(String idDepartment) async {
    try {
      isLoadingCities.value = true;

      final response = await citiesProvider.getCities(idDepartment);
      cities.value = response;
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las ciudades');
    } finally {
      isLoadingCities.value = false;
    }
  }

  Future<void> fetchCities2(String idDepartment) async {
    try {
      isLoadingCities2.value = true;
      final response = await citiesProvider.getCities(idDepartment);
      cities2.value = response;
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las ciudades');
    } finally {
      isLoadingCities2.value = false;
    }
  }

  var identificationTypes = [
    {'id': 1, 'detalle': 'CÉDULA DE CIUDADANÍA'},
    {'id': 2, 'detalle': 'TARJETA DE IDENTIDAD'},
    {'id': 3, 'detalle': 'PASAPORTE'},
    {'id': 4, 'detalle': 'CÉDILA DE EXTRANGERIA'},
    {'id': 5, 'detalle': 'REGISTRO CIVIL'},
  ].obs;

  var selectedIdentificationType = ''.obs;

  void updateIdentificationType(String value) {
    selectedIdentificationType.value = value;
  }

  final List<String> listGender = ['F', 'M', 'OTRO', 'PREFIERO NO DECIRLO'].obs;

  var selectedGender = ''.obs;

  void updateGender(String value) {
    selectedIdentificationType.value = value;
  }

  final List<String> RH = [
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
  ].obs;

  var selectedRH = ''.obs;

  void updateRH(String value) {
    selectedIdentificationType.value = value;
  }

  Future saveData() async{
    
  }
}

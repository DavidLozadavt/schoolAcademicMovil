import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/tuitions_provider.dart';
import 'package:vtschool/src/providers/payments_provider.dart';

class PaymentsController extends GetxController {
  final TuitionsProvider _tuitionsProvider = TuitionsProvider();
  final WompiProvider _wompiProvider = WompiProvider();

  var isLoading = true.obs;
  var isLoading1 = true.obs;
  var tuitionPayments = <Map<String, dynamic>>[].obs;
  var inscriptionPayments = <Map<String, dynamic>>[].obs;

  var selectedPayments = <int>[].obs;
  var totalValue = 0.obs;

  var financialInstitutions = <Map<String, dynamic>>[].obs;
  var selectedInstitutionCode = ''.obs;
  var selectedIdentificationIndex = (-1).obs;
  var selectedPersonTypesIndex = (-1).obs;

  var isChecked = false.obs;

  TextEditingController identificationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var asyncPaymentUrl = ''.obs;
  var responseFindTransactionById = {}.obs;

  RxString selectedFilePath = ''.obs;
  Rx<File> filePath = Rx<File>(File(''));
  var selectedFiles = <int, File>{}.obs;

  Future<void> getTuitionPayments() async {
    try {
      await _tuitionsProvider.getTuitionPayments();
      tuitionPayments.assignAll(_tuitionsProvider.tuitionPayments);
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getRegistrationPayment() async {
    try {
      await _tuitionsProvider.getInscriptionPayments();
      inscriptionPayments.assignAll(_tuitionsProvider.inscriptionPayments);
      isLoading1(true);
    } finally {
      isLoading1(false);
    }
  }

  Future<void> getFinancialInstitutions() async {
    try {
      final institutions = await _wompiProvider.getFinancialInstitutions();

      List<Map<String, dynamic>> fetchedInstitutions =
          List<Map<String, dynamic>>.from(institutions['data']);
      financialInstitutions.assignAll(fetchedInstitutions);
    } catch (error) {
      //print(error);
    }
  }

  void setSelectedInstitutionCode(String code) {
    // print(code);
    selectedInstitutionCode.value = code;
  }

  var personTypes = [
    'Natural',
    'Juridica',
  ].obs;

  void setselectedPersonTypesIndex(int index) {
    selectedPersonTypesIndex.value = index;
    //print(index);
  }

  var identificationTypes = [
    'CC - Cécula de ciudadania',
    'CE - Cécula de extranjeria',
    'NIT - Número de identificación tributaria'
  ].obs;

  void setSelectedIdentificationIndex(int index) {
    selectedIdentificationIndex.value = index;
    //print(index);
    debugPrint('$index');
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void togglePayment(int id, String value) {
    int valDInt = int.parse(value);
    if (selectedPayments.contains(id)) {
      selectedPayments.remove(id);
      totalValue.value -= valDInt;
    } else {
      selectedPayments.add(id);
      totalValue.value += valDInt;
    }
  }

  Future<void> sendTransactionPse() async {
    //print('prueba url: ${asyncPaymentUrl.value}');
    try {
      var data = {
        "codigoInstitucion": selectedInstitutionCode.value.toString(),
        "tipoPersona": selectedPersonTypesIndex.value.toString(),
        "tipoDocumento": selectedIdentificationIndex.value.toString(),
        "numeroDocumento": identificationController.text.toString(),
        "nombreCompleto": nameController.text.toString(),
        "email": emailController.text.toString(),
        "numeroCelular": phoneController.toString(),
        "paymentDescription": phoneController.text.toLowerCase(),
        "amountInCents": totalValue.value
      };
      if (identificationController.text.isEmpty ||
          nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          selectedInstitutionCode.value.isEmpty ||
          selectedIdentificationIndex.value == -1 ||
          selectedPersonTypesIndex.value == -1) {
        Get.snackbar(
          '¡Error!',
          '¡Por favor completa todos los campos!',
        );
      } else {
        Get.defaultDialog(
          title: 'Espera',
          content: const Text('Estamos trabajando en la transaccíon'),
        );
        final responsePse = await _wompiProvider.sendTransactionPse(data);
        Future.delayed(const Duration(seconds: 4), () async {
          final responseGetFind = await _wompiProvider
              .getFindTransactionById(responsePse['data']['id'].toString());
          responseFindTransactionById(responseGetFind);
          debugPrint('$responseFindTransactionById');
          setAsyncPaymentUrl(responseFindTransactionById['payment_method']
              ['extra']['async_payment_url']);
        });
        Future.delayed(const Duration(seconds: 5), () {
          Get.back();
          Get.toNamed('/pse');
          clearData();
          //print(asyncPaymentUrl.value);

          debugPrint(asyncPaymentUrl.value);
        });
      }
    } catch (e) {
      //print('Error al enviar los datos: $e');
      debugPrint('Error al enviar los datos: $e');
    }
  }

  void setAsyncPaymentUrl(String url) {
    asyncPaymentUrl.value = url;
  }

  void clearData() {
    selectedInstitutionCode.value = '';
    selectedIdentificationIndex.value = -1;
    selectedPersonTypesIndex.value = -1;
    isChecked.value = false;
    identificationController.clear();
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    descriptionController.clear();
    totalValue.value = 0;
  }

  void setSelectedFilePath(String path) {
    selectedFilePath.value = path;
  }

  void setFilePath(File path) {
    filePath.value = path;
  }

  void addFile(int paymentId, File file) {
    selectedFiles[paymentId] = file;
  }


  void clearDataPhysicalPayments() {
    selectedFilePath.value = '';
    filePath.value = File('');
    selectedFiles.clear();
  }

   void resetTotalValue() {
    totalValue.value = 0;
    selectedPayments.clear();
  }
}

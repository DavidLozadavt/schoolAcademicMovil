import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/payments/payments_controller.dart';
import 'package:vtschool/src/widgets/cont_sup.dart';

class FormPaymentsScreen extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  FormPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 70,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: listColor[11],
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  'Información personal - PSE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: listColor[11],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                
      
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    if (_paymentsController.financialInstitutions.isEmpty) {
                      return const CircularProgressIndicator();
                    } else {
                      return DropdownButton<String>(
                        isExpanded: true,
                        value: _paymentsController
                                .selectedInstitutionCode.isNotEmpty
                            ? _paymentsController
                                .selectedInstitutionCode.value
                            : null,
                        borderRadius: BorderRadius.circular(10.0),
                        
                        dropdownColor: listColor[10],
                        hint: Text('Selecciona el banco',
                            style: TextStyle(color: listColor[13])),
                        icon: Icon(Icons.arrow_drop_down_circle_outlined,
                            color: listColor[13]),
                        items: _paymentsController.financialInstitutions
                            .map((institution) {
                          return DropdownMenuItem<String>(
                            value: institution['financial_institution_code'],
                            child: Text(
                                institution['financial_institution_name'],
                                style: TextStyle(color: listColor[13])),
                          );
                        }).toList(),
                        onChanged: (code) {
                          if (code != null) {
                            _paymentsController
                                .setSelectedInstitutionCode(code);
                          }
                        },
                      );
                    }
                  }),
                ),
                const SizedBox(height: 20),
                Container(
                   width: 350,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return DropdownButton<int>(
                      isExpanded: true,
                      
                      value: _paymentsController
                                  .selectedPersonTypesIndex.value ==
                              -1
                          ? null
                          : _paymentsController
                              .selectedPersonTypesIndex.value,
                      borderRadius: BorderRadius.circular(10.0),
                      dropdownColor: listColor[10],
                      hint: Text('Seleccionar el tipo de persona',
                          style: TextStyle(color: listColor[13])),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: listColor[13]),
                      items: List.generate(
                          _paymentsController.personTypes.length, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            _paymentsController.personTypes[index],
                            style: TextStyle(color: listColor[13]),
                          ),
                        );
                      }),
                      onChanged: (int? newIndex) {
                        if (newIndex != null) {
                          _paymentsController
                              .setselectedPersonTypesIndex(newIndex);
                        }
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return DropdownButton<int>(
                      isExpanded: true,
                      value: _paymentsController
                                  .selectedIdentificationIndex.value ==
                              -1
                          ? null
                          : _paymentsController
                              .selectedIdentificationIndex.value,
                      borderRadius: BorderRadius.circular(10.0),
                      dropdownColor: listColor[10],
                      hint: Text('Selecciona el tipo de identificación',
                          style: TextStyle(color: listColor[13])),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: listColor[13]),
                      items: List.generate(
                          _paymentsController.identificationTypes.length,
                          (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            _paymentsController
                                .identificationTypes[index],
                            style: TextStyle(color: listColor[13]),
                          ),
                        );
                      }),
                      onChanged: (int? newIndex) {
                        if (newIndex != null) {
                          _paymentsController
                              .setSelectedIdentificationIndex(newIndex);
                        }
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: TextField(
                      controller:
                          _paymentsController.identificationController,
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: listColor[10],
                        hintText: "Digite su número de documento",
                        labelText: 'Número de documento',
                        hintStyle: TextStyle(color: listColor[13]),
                        labelStyle:
                            TextStyle(color: listColor[13], fontSize: 16),
                        prefixIcon: Icon(
                          Icons.person_pin_circle_outlined,
                          color: listColor[13],
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: listColor[14], width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: listColor[13]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 20),
                      ),
                      style: TextStyle(
                        color: listColor[13],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: _paymentsController.nameController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {},
                      keyboardType: TextInputType.name,
                      maxLines: null,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: listColor[10],
                        hintText: "Digite su nombre completo",
                        labelText: 'Nombre completo',
                        hintStyle: TextStyle(color: listColor[13]),
                        labelStyle:
                            TextStyle(color: listColor[13], fontSize: 16),
                        prefixIcon: Icon(
                          Icons.person_pin_circle_outlined,
                          color: listColor[13],
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: listColor[14], width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: listColor[13]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 20),
                      ),
                      style: TextStyle(
                        color: listColor[13],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: _paymentsController.emailController,
                    
                      onChanged: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      maxLines: null,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: listColor[10],
                        hintText: "Digite su correo electrónico",
                        labelText: 'Correo electrónico',
                        hintStyle: TextStyle(color: listColor[13]),
                        labelStyle:
                            TextStyle(color: listColor[13], fontSize: 16),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: listColor[13],
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: listColor[14], width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: listColor[13]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 20),
                      ),
                      style: TextStyle(
                        color: listColor[13],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: _paymentsController.phoneController,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
                      keyboardType: TextInputType.phone,
                      maxLines: null,
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: listColor[10],
                        hintText: "Digite su número celular",
                        labelText: 'Número celular',
                        hintStyle: TextStyle(color: listColor[13]),
                        labelStyle:
                            TextStyle(color: listColor[13], fontSize: 16),
                        prefixIcon: Icon(
                          Icons.phone_iphone,
                          color: listColor[13],
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: listColor[14], width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: listColor[13]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 20),
                      ),
                      style: TextStyle(
                        color: listColor[13],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: _paymentsController.descriptionController,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: listColor[10],
                        hintText: "Descripción",
                        labelText: 'Descripción',
                        hintStyle: TextStyle(color: listColor[13]),
                        labelStyle:
                            TextStyle(color: listColor[13], fontSize: 16),
                        prefixIcon: Icon(
                          Icons.note_alt_outlined,
                          color: listColor[13],
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: listColor[14], width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: listColor[13]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 20),
                      ),
                      style: TextStyle(
                        color: listColor[13],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: listColor[10],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: listColor[13].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Obx(() => CheckboxListTile(
                          title: GestureDetector(
                            onTap: () {
                              showTermsAndConditions(
                                context,
                              );
                            },
                            child: Text(
                                'Acepto haber leído los términos y condiciones y la política de privacidad',
                                style: TextStyle(color: listColor[13])),
                          ),
                          value: _paymentsController.isChecked.value,
                          onChanged: (bool? value) {
                            _paymentsController.toggleCheckbox();
                          },
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: listColor[13],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: _paymentsController.isChecked.value
                          ? () async {
                                 await _paymentsController
                                    .sendTransactionPse();
                             /*Get.toNamed('/pruebawompi');
                              if (_paymentsController.identificationController
                                      .text.isNotEmpty ||
                                  _paymentsController
                                      .nameController.text.isNotEmpty ||
                                  _paymentsController
                                      .emailController.text.isNotEmpty ||
                                  _paymentsController
                                      .phoneController.text.isNotEmpty ||
                                  _paymentsController.descriptionController
                                      .text.isNotEmpty) {
                                Get.defaultDialog(
                                  title: 'Espera',
                                  content: const Text(
                                      'Estamos trabajando en la transaccíon'),
                                );
                                await _paymentsController
                                    .sendTransactionPse();
      
                                Future.delayed(const Duration(seconds: 5), () {
                                  Get.back();
                                  Get.toNamed('/pruebawompi');
                                  _paymentsController.clearData();
                                  print(_paymentsController
                                      .asyncPaymentUrl.value);
                                });
                              } else {
                                Get.snackbar(
                                  '¡Error!',
                                  '¡Por favor completa todos los campos!',
                                );
                              }*/
                            }
                          : null,
                      child: Text(
                        'Continuar',
                        style: TextStyle(color: listColor[10]),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showTermsAndConditions(BuildContext context) {
    Get.bottomSheet(
      showTermsAndConditionsModal(context),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  Widget showTermsAndConditionsModal(BuildContext context) {
    return Container(
      height: 700,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            listColor[13],
            listColor[11],
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ContSup(),
              const SizedBox(height: 20),
              Text(
                'Terminos y condiciones',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: listColor[10],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                height: 500,
                margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: listColor[10]),
                ),
                child: SfPdfViewer.network(
                  enableTextSelection: true,
                  enableDoubleTapZooming: true,
                  enableDocumentLinkAnnotation: true,
                  enableHyperlinkNavigation: true,
                  canShowScrollStatus: true,
                  'https://wompi.com/assets/downloadble/reglamento-Usuarios-Colombia.pdf',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_paymentsController.isChecked.value == false) {
                    _paymentsController.isChecked.value =
                        !_paymentsController.isChecked.value;
                  }
                  Get.back();
                },
                child: const Text('De acuerdo'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

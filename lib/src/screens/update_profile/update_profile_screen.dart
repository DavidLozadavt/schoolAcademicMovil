import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';
import 'package:vtschool/src/screens/update_profile/update_profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  final UpdateProfileController _updateProfileController =
      Get.put(UpdateProfileController());
  final ProfileUserController _profileUserController =
      Get.put(ProfileUserController());
  UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/otp.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 50.0, bottom: 16.0),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    width: 370,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ACTUALIZAR PERFIL',
                            style: TextStyle(
                              color: listColor[15],
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Obx(
                              () => GestureDetector(
                                onTap: () => showImagePickerModal(
                                    context, _profileUserController),
                                child: ClipOval(
                                  child: _updateProfileController
                                              .profileImage.value ==
                                          null
                                      ? Image.network(
                                          _profileUserController
                                                      .userProfile['persona']
                                                  ?['rutaFoto'] ??
                                              '',
                                          width: 110,
                                          height: 110,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/profile.png',
                                              width: 110,
                                              height: 110,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.file(
                                          _updateProfileController
                                              .profileImage.value!,
                                          width: 110,
                                          height: 110,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/profile.png',
                                              width: 110,
                                              height: 110,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField("Descripción de Perfil",
                              _updateProfileController.descriptionController,
                              icon: Icons.description_outlined),
                          _buildTextField("Primer nombre",
                              _updateProfileController.firstNameController,
                              icon: Icons.person),
                          _buildTextField("Segundo Nombre",
                              _updateProfileController.middleNameController,
                              icon: Icons.person),
                          _buildTextField("Primer Apellido",
                              _updateProfileController.lastName1Controller,
                              icon: Icons.person),
                          _buildTextField("Segundo Apellido",
                              _updateProfileController.lastName2Controller,
                              icon: Icons.person),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: _buildTextField(
                                icon: Icons.date_range_rounded,
                                'Fecha nacimiento',
                                _updateProfileController.dateController,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController
                                  .identificationTypes.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: _updateProfileController
                                        .selectedIdentificationType
                                        .value
                                        .isNotEmpty
                                    ? _updateProfileController
                                        .selectedIdentificationType.value
                                    : null,
                                borderRadius: BorderRadius.circular(10.0),
                                dropdownColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: listColor[15]),
                                items: _updateProfileController
                                    .identificationTypes
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['id'].toString(),
                                    child: Text(item['detalle'].toString(),
                                        style: TextStyle(color: listColor[15])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _updateProfileController
                                      .selectedIdentificationType
                                      .value = value!;
                                },
                                hint: Text('Tipo de identificación',
                                    style: TextStyle(color: listColor[15])),
                              );
                            }),
                          ),
                          _buildTextField("Identificación",
                              _updateProfileController.idNumberController,
                              icon: Icons.badge_outlined),
                          _buildTextField("Celular",
                              _updateProfileController.mobileController,
                              icon: Icons.contact_phone_outlined),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController.listGender.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: _updateProfileController
                                        .selectedGender.value.isNotEmpty
                                    ? _updateProfileController
                                        .selectedGender.value
                                    : null,
                                borderRadius: BorderRadius.circular(10.0),
                                dropdownColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: listColor[15]),
                                items: _updateProfileController.listGender
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: TextStyle(color: listColor[15])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _updateProfileController
                                      .selectedGender.value = value!;
                                },
                                hint: Text('Sexo',
                                    style: TextStyle(color: listColor[15])),
                              );
                            }),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController.RH.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: _updateProfileController
                                        .selectedRH.value.isNotEmpty
                                    ? _updateProfileController.selectedRH.value
                                    : null,
                                borderRadius: BorderRadius.circular(10.0),
                                dropdownColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: listColor[15]),
                                items: _updateProfileController.RH.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: TextStyle(color: listColor[15])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _updateProfileController.selectedRH.value =
                                      value!;
                                },
                                hint: Text('RH',
                                    style: TextStyle(color: listColor[15])),
                              );
                            }),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController
                                  .departments.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: _updateProfileController
                                        .selectedDepartment.value.isNotEmpty
                                    ? _updateProfileController
                                        .selectedDepartment.value
                                    : null,
                                borderRadius: BorderRadius.circular(10.0),
                                dropdownColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: listColor[15]),
                                items: _updateProfileController.departments
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['id'].toString(),
                                    child: Text(item['descripcion'],
                                        style: TextStyle(color: listColor[15])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _updateProfileController
                                      .selectedDepartment.value = value!;
                                  _updateProfileController.selectedCity.value =
                                      '';
                                  _updateProfileController.fetchCities(value);
                                },
                                hint: Text('Departamento de nacimiento',
                                    style: TextStyle(color: listColor[15])),
                              );
                            }),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController
                                  .isLoadingCities.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: _updateProfileController
                                          .selectedCity.value.isNotEmpty
                                      ? _updateProfileController
                                          .selectedCity.value
                                      : null,
                                  borderRadius: BorderRadius.circular(10.0),
                                  dropdownColor: Colors.white,
                                  underline: const SizedBox.shrink(),
                                  icon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: listColor[15]),
                                  items: _updateProfileController.cities
                                      .map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'].toString(),
                                      child: Text(item['descripcion'],
                                          style:
                                              TextStyle(color: listColor[15])),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _updateProfileController
                                        .selectedCity.value = value!;
                                  },
                                  hint: Text('Ciudad de nacimiento',
                                      style: TextStyle(color: listColor[15])),
                                );
                              }
                            }),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController
                                  .departments.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: _updateProfileController
                                        .selectedDepartment2.value.isNotEmpty
                                    ? _updateProfileController
                                        .selectedDepartment2.value
                                    : null,
                                borderRadius: BorderRadius.circular(10.0),
                                dropdownColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: listColor[15]),
                                items: _updateProfileController.departments
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['id'].toString(),
                                    child: Text(item['descripcion'],
                                        style: TextStyle(color: listColor[15])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _updateProfileController
                                      .selectedDepartment2.value = value!;
                                  _updateProfileController.selectedCity2.value =
                                      '';
                                  _updateProfileController.fetchCities2(value);
                                },
                                hint: Text(
                                  'Departamento de ubicación',
                                  style: TextStyle(color: listColor[15]),
                                ),
                              );
                            }),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            margin:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: listColor[16].withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              if (_updateProfileController
                                  .isLoadingCities2.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: _updateProfileController
                                          .selectedCity2.value.isNotEmpty
                                      ? _updateProfileController
                                          .selectedCity2.value
                                      : null,
                                  borderRadius: BorderRadius.circular(10.0),
                                  dropdownColor: Colors.white,
                                  underline: const SizedBox.shrink(),
                                  icon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: listColor[15]),
                                  items: _updateProfileController.cities2
                                      .map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'].toString(),
                                      child: Text(item['descripcion'],
                                          style:
                                              TextStyle(color: listColor[15])),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _updateProfileController
                                        .selectedCity2.value = value!;
                                  },
                                  hint: Text('Ciudad de ubicación',
                                      style: TextStyle(color: listColor[15])),
                                );
                              }
                            }),
                          ),
                          _buildTextField("Dirección",
                              _updateProfileController.addressController,
                              icon: Icons.location_on_outlined),
                          _buildTextField("Teléfono Fijo",
                              _updateProfileController.landlineController,
                              icon: Icons.contact_phone_outlined),
                          _buildTextField("Correo Electrónico",
                              _updateProfileController.emailController,
                              icon: Icons.contact_mail_outlined),
                          ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: listColor[15],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: const Text(
                              'GUARDAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickerModal(
      BuildContext context, ProfileUserController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Tomar una foto"),
                onTap: () {
                  _updateProfileController.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Seleccionar de la galería"),
                onTap: () {
                  _updateProfileController.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      IconData icon = Icons.import_contacts}) {
    /*
    
    onChanged: (value) {},
                          
                         
                          
                           
                            
                           
                        ), */
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: label,
          labelText: label,
          hintStyle: TextStyle(color: listColor[15]),
          labelStyle: TextStyle(
              color: listColor[15], fontSize: 16, fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            icon,
            color: listColor[15],
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: listColor[15], width: 5),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: listColor[15], width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: listColor[15], width: 1.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20),
        ),
        style: TextStyle(
          color: listColor[15],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      _updateProfileController.dateController.text = formattedDate;
    }
  }
}

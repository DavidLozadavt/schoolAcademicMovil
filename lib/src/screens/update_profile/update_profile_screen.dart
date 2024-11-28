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
                child: Expanded(
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
                                _updateProfileController.descriptionController, icon: Icons.description_outlined),
                            _buildTextField("Primer nombre",
                                _updateProfileController.firstNameController, icon: Icons.person),
                            _buildTextField("Nombre 2",
                                _updateProfileController.middleNameController, icon: Icons.person),
                            _buildTextField("Apellido 1",
                                _updateProfileController.lastName1Controller,  icon: Icons.person),
                            _buildTextField("Apellido 2",
                                _updateProfileController.lastName2Controller,  icon: Icons.person),
                            _buildTextField("Identificación",
                                _updateProfileController.idNumberController,  icon: Icons.person),
                            _buildTextField("Celular",
                                _updateProfileController.mobileController),
                            _buildTextField("Dirección",
                                _updateProfileController.addressController),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: _buildTextField(
                                  'Fecha nacimiento',
                                  _updateProfileController.dateController,
                                ),
                              ),
                            ),
                            /*_buildTextField("Tipo de Identificación", controller.tipoIdController),
                                   
                                  
                                    _buildTextField("Sexo", controller.sexoController),
                                    _buildTextField("RH", controller.rhController),
                                    _buildTextField("Departamento de Nacimiento", controller.depNacimientoController),
                                    _buildTextField("Ciudad de Nacimiento", controller.ciudadNacimientoController),
                                    _buildTextField("Departamento de Ubicación", controller.depUbicacionController),
                                    _buildTextField("Ciudad de Ubicación", controller.ciudadUbicacionController),
                                    
                                    _buildTextField("Teléfono Fijo", controller.telefonoFijoController),
                                    _buildTextField("Correo Electrónico", controller.correoController),*/
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
      {TextInputType keyboardType = TextInputType.text, IconData icon = Icons.import_contacts}) {
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

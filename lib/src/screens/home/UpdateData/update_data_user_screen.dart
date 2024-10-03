import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/home/UpdateData/update_data_controller.dart';

class UpdateStudentDataPage extends StatelessWidget {
  final UpdateStudentDataController controller =
      Get.put(UpdateStudentDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar mis datos'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFDC4A), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFDC4A), 
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: controller.currentStep.value,
                    onStepTapped: (step) => controller.currentStep.value = step,
                    onStepContinue: controller.nextStep,
                    onStepCancel: controller.previousStep,
                    steps: [
                      Step(
                        title: const Text('Datos Personales'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(controller.nameOneController,
                                'Nombre 1', Icons.person),
                            const SizedBox(height: 16),
                             _buildTextField(controller.nameTwoController,
                                'Nombre 2', Icons.person),
                            const SizedBox(height: 16),
                             _buildTextField(controller.lastNameController,
                                'Apellido', Icons.person),
                            const SizedBox(height: 16),
                            _buildTextField(controller.phoneController,
                                'Teléfono', Icons.phone,
                                keyboardType: TextInputType.phone),
                            const SizedBox(height: 16),
                            _buildTextField(controller.emailController, 'Email',
                                Icons.email,
                                keyboardType: TextInputType.emailAddress),
                            const SizedBox(height: 16),
                            _buildTextField(controller.identificacionController,
                                'Identificación', Icons.perm_identity),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () => _selectDate(
                                  context), 
                              child: AbsorbPointer(
                                child: _buildTextField(
                                    controller.fechaNacController,
                                    'Fecha nacimiento',
                                    Icons.calendar_today),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep.value >= 0,
                        state: controller.currentStep.value > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Ubicación'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(controller.addressController,
                                'Dirección', Icons.location_on),
                          ],
                        ),
                        isActive: controller.currentStep.value >= 1,
                        state: controller.currentStep.value > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (controller.currentStep.value > 0)
                            TextButton(
                              onPressed: details.onStepCancel,
                              style: TextButton.styleFrom(),
                              child: const Text('Atrás'),
                            ),
                        const  SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Continuar'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.indigoAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.indigoAccent,
            colorScheme:const ColorScheme.light(primary: Colors.indigoAccent),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      controller.fechaNacController.text =
          "${pickedDate.toLocal()}".split(' ')[0];
    }
  }
}

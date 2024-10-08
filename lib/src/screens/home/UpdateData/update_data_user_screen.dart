import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/home/UpdateData/update_data_controller.dart';

class UpdateStudentDataPage extends StatelessWidget {
  final UpdateStudentDataController controller =
      Get.put(UpdateStudentDataController());
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar mis datos'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFDC4A),
        elevation: 0,
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
            return Form(  // Se agrega el Form para validación
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: controller.currentStep.value,
                      onStepTapped: (step) =>
                          controller.currentStep.value = step,
                      onStepContinue: () {
                        if (controller.currentStep.value == 1) {
                          // Validar cuando se esté en el último paso
                          if (_formKey.currentState!.validate()) {
                            controller.nextStep();
                          }
                        } else {
                          controller.nextStep();
                        }
                      },
                      onStepCancel: controller.previousStep,
                      steps: [
                        Step(
                          title: const Text('Datos Personales'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextField(controller.nameOneController,
                                  'Primer Nombre', Icons.person),
                              const SizedBox(height: 16),
                              _buildTextField(controller.nameTwoController,
                                  'Segundo Nombre', Icons.person),
                              const SizedBox(height: 16),
                              _buildTextField(controller.lastNameController,
                                  'Primer Apellido', Icons.person),
                              const SizedBox(height: 16),
                              _buildTextField(controller.lastName2Controller,
                                  'Segundo Apellido', Icons.person),
                              const SizedBox(height: 16),
                              _buildTextField(controller.phoneController,
                                  'Teléfono', Icons.phone,
                                  keyboardType: TextInputType.phone),
                              const SizedBox(height: 16),
                              _buildTextField(controller.phonefijeController,
                                  'Teléfono Fijo', Icons.phone,
                                  keyboardType: TextInputType.phone),
                              const SizedBox(height: 16),
                              _buildTextField(controller.emailController, 'Email',
                                  Icons.email,
                                  keyboardType: TextInputType.emailAddress),
                              const SizedBox(height: 16),
                              _buildTextField(
                                  controller.identificacionController,
                                  'Identificación',
                                  Icons.perm_identity),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: () => _selectDate(context),
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
                                  'Dirección', Icons.location_on,
                                  isRequired: true), // Añadir validación obligatoria
                              const SizedBox(height: 16),
                              Obx(() {
                                // Indicador de carga para departamentos
                                if (controller.departamentos.isEmpty) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: controller.selectedDepartamento.value
                                          .isNotEmpty
                                      ? controller.selectedDepartamento.value
                                      : null,
                                  items: controller.departamentos.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'].toString(),
                                      child: Text(item['descripcion']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedDepartamento.value =
                                        value!;
                                    controller.selectedCiudad.value = '';
                                    controller.fetchCityes(value);
                                  },
                                  hint: const Text(
                                      'Seleccione el departamento'),
                                );
                              }),
                              const SizedBox(height: 16),
                              Obx(() {
                                // Indicador de carga para ciudades
                                if (controller.isLoadingCiudades.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return DropdownButton<String>(
                                    isExpanded: true,
                                    value: controller.selectedCiudad.value
                                            .isNotEmpty
                                        ? controller.selectedCiudad.value
                                        : null,
                                    items: controller.ciudades.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'].toString(),
                                        child: Text(item['descripcion']),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.selectedCiudad.value = value!;
                                    },
                                    hint: const Text('Seleccione la ciudad'),
                                  );
                                }
                              }),
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
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFDC4A),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              child: Text(controller.currentStep.value < 1
                                  ? 'Siguiente'
                                  : 'Actualizar'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text, bool isRequired = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              return null;
            }
          : null,
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
      // Formato de fecha
      String formattedDate =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      // Actualiza el campo de texto con la fecha seleccionada
      Get.find<UpdateStudentDataController>().fechaNacController.text =
          formattedDate;
    }
  }
}

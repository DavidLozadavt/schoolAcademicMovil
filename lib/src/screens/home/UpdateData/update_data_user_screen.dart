import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/home/UpdateData/update_data_controller.dart';

class UpdateStudentDataPage extends StatelessWidget {
  final UpdateStudentDataController controller = Get.put(UpdateStudentDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar mis datos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: StepperType.horizontal,  // Aquí se especifica que el Stepper es horizontal
                    currentStep: controller.currentStep.value,
                    onStepTapped: (step) => controller.currentStep.value = step,
                    onStepContinue: controller.nextStep,
                    onStepCancel: controller.previousStep,
                    steps: [
                      Step(
                        title: const Text('Datos Personales'),
                        content: Column(
                          children: [
                            TextField(
                              controller: controller.nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nombre completo',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: controller.phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Teléfono',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
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
                          children: [
                            TextField(
                              controller: controller.addressController,
                              decoration: const InputDecoration(
                                labelText: 'Dirección',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep.value >= 1,
                        state: controller.currentStep.value > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                    controlsBuilder: (BuildContext context, ControlsDetails details) {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: const Text('Continuar'),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Atrás'),
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
}

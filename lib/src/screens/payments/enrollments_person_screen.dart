import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/payments/payments_controller.dart';
import 'package:vtschool/src/widgets/card_enrollments_person.dart';

class EnrollmentsPersonScreen extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  EnrollmentsPersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: 50,
            child: const Text(
              'Matriculas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
         
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => _paymentsController.isLoading.value
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: _paymentsController.refreshItems,
                      child: _paymentsController.enrollmentsByPerson.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes matriculas',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _paymentsController
                                  .enrollmentsByPerson.length,
                              itemBuilder: ((context, index) {
                                return Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                    //   await _paymentsController.getTuitionPayments(_paymentsController
                                    //       .enrollmentsByPerson[index]['id']);
                                    //   Get.toNamed('/payments');
                                    // 
                                    },
                                    child: CardEnrollmentsPerson(
                                      date: _paymentsController
                                          .enrollmentsByPerson[index]['fecha'],
                                      name: _paymentsController
                                              .enrollmentsByPerson[index]
                                          ['persona']['nombre1'],
                                      lastName: _paymentsController
                                              .enrollmentsByPerson[index]
                                          ['persona']['apellido1'],
                                      program: _paymentsController
                                                          .enrollmentsByPerson[
                                                      index][
                                                  'asignacion_periodo_programa_jornada']
                                              ['asignacion_periodo_programa']
                                          ['programa']['nombrePrograma'],
                                      gradeOrSemester: _paymentsController
                                              .enrollmentsByPerson[index]
                                          ['grado']['nombreGrado'],
                                      educationalLevel: _paymentsController
                                                          .enrollmentsByPerson[
                                                      index][
                                                  'asignacion_periodo_programa_jornada']
                                              ['asignacion_periodo_programa'][
                                          'programa']['nivelEducativo']['nombreNivel'],
                                      status: _paymentsController
                                          .enrollmentsByPerson[index]['estado'],
                                    ),
                                  ),
                                );
                              }),
                            ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

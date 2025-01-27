import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtschool/src/screens/assigned_courses_teacher%20/assigned_courses_teacher_controller.dart';

class StatisticsBySubjects extends StatelessWidget {
  StatisticsBySubjects({super.key});

  final AssignedCoursesTeacherController _assignedCoursesTeacherController =
      Get.put(AssignedCoursesTeacherController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _assignedCoursesTeacherController.rapsSession.clear();
              Get.back();
            },
          ),
          title: const Text('Gráfico Estadístico'),
        ),
        body: Column(
          children: [
            Obx(() {
              if (_assignedCoursesTeacherController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_assignedCoursesTeacherController
                  .rapsBySubject.isEmpty) {
                return const Center(child: Text('No hay datos disponibles'));
              } else {
                List<DoughnutSeries<Map<String, dynamic>, String>>
                    doughnutSeries = [
                  DoughnutSeries<Map<String, dynamic>, String>(
                    dataSource: _assignedCoursesTeacherController.rapsBySubject,
                    xValueMapper: (Map<String, dynamic> data, _) =>
                        data['nombre_materia'],
                    yValueMapper: (Map<String, dynamic> data, _) => 1,
                    dataLabelMapper: (Map<String, dynamic> data, _) =>
                        data['nombre_materia'],
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    onPointTap: (ChartPointDetails details) async {
                      int pointIndex = details.pointIndex!;
                      var selectedData = _assignedCoursesTeacherController
                          .rapsBySubject[pointIndex];

                      await _assignedCoursesTeacherController.getSessionRaps(
                          selectedData['id_materia'].toString());
                    },
                  )
                ];
                return Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SfCircularChart(
                    title: const ChartTitle(text: 'Progreso de la ficha'),
                    legend: const Legend(isVisible: true),
                    series: doughnutSeries,
                  ),
                );
              }
            }),
            const SizedBox(height: 16),
            Obx(() {
              if (_assignedCoursesTeacherController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_assignedCoursesTeacherController
                  .rapsSession.isEmpty) {
                return const Center(child: Text('No hay datos disponibles'));
              } else {
                var data = _assignedCoursesTeacherController.rapsSession[0];

                double totalHoursRap =
                    double.parse(data['horas_totales_rap'] ?? '0.0');
                double totalHoursExecuted =
                    double.parse(data['horas_totales_ejecutadas']);
                double remainingHours =
                    double.parse(data['horas_restantes'] ?? '0.0');

                double executedPercentage =
                    (totalHoursExecuted / totalHoursRap) * 100;
                double remainingPercentage =
                    (remainingHours / totalHoursRap) * 100;

                List<DoughnutSeries<Map<String, dynamic>, String>>
                    doughnutSeries = [
                  DoughnutSeries<Map<String, dynamic>, String>(
                    dataSource: [
                      {
                        'category': '$executedPercentage%',
                        'value': executedPercentage
                      },
                      {
                        'category': '$remainingPercentage%',
                        'value': remainingPercentage
                      }
                    ],
                    xValueMapper: (Map<String, dynamic> data, _) =>
                        data['category'],
                    yValueMapper: (Map<String, dynamic> data, _) =>
                        data['value'],
                    dataLabelMapper: (Map<String, dynamic> data, _) =>
                        data['category'],
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    pointColorMapper: (Map<String, dynamic> data, _) {
                      if (data['category'] == '$executedPercentage%') {
                        return Colors.green;
                      } else {
                        return Colors.red;
                      }
                    },
                    onPointTap: (ChartPointDetails details) async {
                      int pointIndex = details.pointIndex ?? -1;

                      if (pointIndex < 0 ||
                          pointIndex >=
                              _assignedCoursesTeacherController
                                  .rapsSession.length) {
                        return;
                      }

                      var selectedData = _assignedCoursesTeacherController
                          .rapsSession[pointIndex];
                      String category = selectedData['category'] ?? '';

                      if (category == '$remainingPercentage%') {
                        return;
                      }
                      Get.defaultDialog(
                          title: 'Detalles',
                          content: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Materia: ${selectedData['nombre_materia']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Horas Totales:'),
                                    Text('${selectedData['horas_totales_rap']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Horas ejecutadas:'),
                                    Text(
                                        '${selectedData['horas_totales_ejecutadas']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Horas restantes:'),
                                    Text(
                                        '${selectedData['sesiones_faltantes']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Porcentaje de ejecución:'),
                                    Text('$executedPercentage%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Porcentaje faltante:'),
                                    Text('$remainingPercentage%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          textConfirm: 'Aceptar',
                          onConfirm: () => Get.back());
                    },
                  ),
                ];
                return Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SfCircularChart(
                    legend: const Legend(isVisible: true),
                    series: doughnutSeries,
                  ),
                );
              }
            }),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (_assignedCoursesTeacherController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_assignedCoursesTeacherController
                    .rapsBySubject.isEmpty) {
                  return const Center(child: Text('No hay datos disponibles'));
                } else {
                  return ListView.builder(
                    itemCount:
                        _assignedCoursesTeacherController.rapsBySubject.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _assignedCoursesTeacherController.rapsBySubject[index]
                              ['nombre_materia'],
                        ),
                      );
                    }),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtschool/src/screens/assigned_courses_teacher%20/assigned_courses_teacher_controller.dart';

class StatisticsByCourseScreen extends StatelessWidget {
  StatisticsByCourseScreen({super.key});
  final AssignedCoursesTeacherController _assignedCoursesTeacherController =
      Get.put(AssignedCoursesTeacherController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gráfico Estadístico'),
          
        ),
        body: Center(
          child: Column(
            children: [
              Obx(() {
                if (_assignedCoursesTeacherController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_assignedCoursesTeacherController
                    .competences.isEmpty) {
                  return const Center(child: Text('No hay datos disponibles'));
                } else {
                  List<DoughnutSeries<Map<String, dynamic>, String>>
                      doughnutSeries = [
                    DoughnutSeries<Map<String, dynamic>, String>(
                      dataSource: _assignedCoursesTeacherController.competences,
                      xValueMapper: (Map<String, dynamic> data, _) =>
                          data['nombre_materia'],
                      yValueMapper: (Map<String, dynamic> data, _) => 1,
                      dataLabelMapper: (Map<String, dynamic> data, _) =>
                          data['nombre_materia'],
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      onPointTap: (ChartPointDetails details) {
                        int pointIndex = details.pointIndex!;
                        var selectedData = _assignedCoursesTeacherController
                            .competences[pointIndex];
                       
                        
                        Get.defaultDialog(
                          title: 'Información',
                          middleText:
                              'Desea ver las estadisticas de: ${selectedData['nombre_materia']}',
                          textConfirm: 'Aceptar',
                          textCancel: 'Cancelar',
                          onConfirm: () async {
                            String idCourse = _assignedCoursesTeacherController
                                .curseById['codigoFicha']
                                .toString();
                            String idSubject = selectedData['id_materia'].toString();
                            String idProgram = _assignedCoursesTeacherController
                                .curseById['idPrograma']
                                .toString();
                            await _assignedCoursesTeacherController
                                .getRapsBySubject(
                                    idCourse, idSubject, idProgram);
                            Get.back();
                            Get.toNamed('/statistics_by_subject');
                          },
                          onCancel: () {},
                        );
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
            ],
          ),
        ),
        //  Obx(() {
        //   if (_assignedCoursesTeacherController.isLoading.value) {
        //     return Center(child: CircularProgressIndicator());
        //   } else if (_assignedCoursesTeacherController.competences.isEmpty) {
        //     return Center(child: Text('No hay datos disponibles'));
        //   } else {
        //     // Preparar los datos para el gráfico
        //     List<PieSeries<Map<String, dynamic>, String>> pieSeries = [
        //       PieSeries<Map<String, dynamic>, String>(
        //         dataSource: _assignedCoursesTeacherController.competences,
        //         xValueMapper: (Map<String, dynamic> data, _) => data['nombre_materia'],
        //         yValueMapper: (Map<String, dynamic> data, _) => data['id_materia'],
        //         dataLabelMapper: (Map<String, dynamic> data, _) => data['nombre_materia'],
        //         dataLabelSettings: DataLabelSettings(isVisible: true),
        //       )
        //     ];

        //     return SfCircularChart(
        //       title: ChartTitle(text: 'Distribución de Materias'),
        //       legend: Legend(isVisible: true),
        //       series: pieSeries,
        //     );
        //   }
        // }),
        //Obx(() {
        //   if (_assignedCoursesTeacherController.isLoading.value) {
        //     return const Center(child: CircularProgressIndicator());
        //   } else if (_assignedCoursesTeacherController.competences.isEmpty) {
        //     return const Center(child: Text('No hay datos disponibles'));
        //   } else {
        //     List<_ChartData> chartData =
        //         _assignedCoursesTeacherController.competences.map((competence) {
        //       print(competence);
        //       return _ChartData(
        //         competence['nombre_materia'],
        //         competence['id_materia'],
        //       );
        //     }).toList();

        //     return SfCartesianChart(
        //       primaryXAxis: const CategoryAxis(),
        //       title: const ChartTitle(text: 'Título del Gráfico'),
        //       legend: const Legend(isVisible: true),
        //       tooltipBehavior: TooltipBehavior(enable: true),
        //       series: <CartesianSeries>[
        //         ColumnSeries<_ChartData, String>(
        //           dataSource: chartData,
        //           xValueMapper: (_ChartData data, _) => data.nombreMateria,
        //           yValueMapper: (_ChartData data, _) => data.idMateria,
        //           name: 'Nombre de la Serie',
        //           dataLabelSettings: const DataLabelSettings(isVisible: true),
        //         ),
        //       ],
        //     );
        //   }
        // }),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.nombreMateria, this.idMateria);

  final String nombreMateria;
  final int idMateria;
}

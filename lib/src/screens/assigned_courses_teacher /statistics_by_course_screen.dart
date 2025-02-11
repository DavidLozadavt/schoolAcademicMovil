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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Obx(() {
                  if (_assignedCoursesTeacherController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (_assignedCoursesTeacherController
                      .competences.isEmpty) {
                    return const Center(
                        child: Text('No hay datos disponibles'));
                  } else {
                    Map<String, int> attendanceCounts =
                        _assignedCoursesTeacherController.getAttendanceCounts();
                    int totalPresent = attendanceCounts['Present'] ?? 0;
                    int totalAbsent = attendanceCounts['Absent'] ?? 0;
                    int totalStudents = totalPresent + totalAbsent;
                    double attendancePercentage = totalStudents > 0
                        ? (totalPresent / totalStudents) * 100
                        : 0;
                    List<Map<String, dynamic>> chartData = [
                      {
                        'status': 'Presente',
                        'count': attendanceCounts['Present'] ?? 0,
                        'color': Colors.blue.withOpacity(0.5)
                      },
                      {
                        'status': 'Ausente',
                        'count': attendanceCounts['Absent'] ?? 0,
                        'color': Colors.pink.withOpacity(0.5)
                      },
                    ];

                    return Container(
                      width: 350,
                      height: 500,
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
                      child: Column(
                        children: [
                          const Text(
                            'Estadisticas de asistencia',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Presente: $totalPresent',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Total Ausente: $totalAbsent',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Porcentaje de Asistencia: ${attendancePercentage.toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: SfCartesianChart(
                              primaryXAxis: const CategoryAxis(
                                title: AxisTitle(text: 'Estado de asistencia'),
                              ),
                              primaryYAxis: const NumericAxis(
                                title: AxisTitle(text: 'Numero de estudiantes'),
                              ),
                              series: <CartesianSeries<Map<String, dynamic>,
                                  String>>[
                                ColumnSeries<Map<String, dynamic>, String>(
                                  dataSource: chartData,
                                  xValueMapper: (data, _) => data[
                                      'status'], // Acceder al campo 'status'
                                  yValueMapper: (data, _) =>
                                      data['count'], // Acceder al campo 'count'
                                  pointColorMapper: (data, _) => data['color'],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 10.0,
                ),
                Obx(() {
                  if (_assignedCoursesTeacherController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (_assignedCoursesTeacherController
                      .competences.isEmpty) {
                    return const Center(
                        child: Text('No hay datos disponibles'));
                  } else {
                    List<DoughnutSeries<Map<String, dynamic>, String>>
                        doughnutSeries = [
                      DoughnutSeries<Map<String, dynamic>, String>(
                        dataSource:
                            _assignedCoursesTeacherController.competences,
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
                              String idCourse =
                                  _assignedCoursesTeacherController
                                      .curseById['codigoFicha']
                                      .toString();
                              String idSubject =
                                  selectedData['id_materia'].toString();
                              String idProgram =
                                  _assignedCoursesTeacherController
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
                      width: 350,
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
                const SizedBox(
                  height: 10.0,
                ),
                Obx(() => Center(
                      child: Container(
                        width: 350,
                        //height: 300,
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
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 18.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String?>(
                                  value: _assignedCoursesTeacherController
                                      .selectedOption.value,
                                  hint: const Text('Selecciona una opción'),
                                  onChanged: (String? newValue) {
                                    _assignedCoursesTeacherController
                                        .selectedOption.value = newValue;
                                    String id =
                                        _assignedCoursesTeacherController
                                            .selectedCourseId.value;
                                    if (newValue != null) {
                                      _assignedCoursesTeacherController
                                          .getStatusByMatriculation(
                                              id, newValue);
                                    }
                                  },
                                  items: [
                                    'EN FORMACION',
                                    'RETIRO VOLUNTARIO',
                                    'POR EVALUAR',
                                    'TRASLADADO',
                                    'APLAZADO',
                                    'APROBADO',
                                    'CURSADO',
                                  ].map<DropdownMenuItem<String?>>(
                                      (String value) {
                                    return DropdownMenuItem<String?>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                if (_assignedCoursesTeacherController
                                    .dataStatusByMatriculation.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No hay datos disponibles para mostrar.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  );
                                } else {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: DataTable(
                                        columnSpacing:
                                            16, // Espaciado entre columnas
                                        headingRowColor:
                                            WidgetStateProperty.all(
                                                Colors.blueAccent.shade100),
                                        headingTextStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        dataRowColor:
                                            WidgetStateProperty.resolveWith(
                                                (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return Colors
                                                .blueAccent; 
                                          }
                                          return Colors.grey
                                              .shade50; // Color base para las filas
                                        }),
                                        dataTextStyle: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                        border: TableBorder.all(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        ),
                                        columns: const [
                                          DataColumn(
                                              label: Text('Nombre Completo')),
                                          DataColumn(
                                              label: Text('Identificación')),
                                          DataColumn(label: Text('Estado')),
                                        ],
                                        rows: _assignedCoursesTeacherController
                                            .dataStatusByMatriculation
                                            .map((data) {
                                          final persona = data['persona'];
                                          final nombreCompleto =
                                              '${persona["nombre1"]} ${persona["nombre2"] ?? ""} ${persona["apellido1"]} ${persona["apellido2"]}';
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                  Text(nombreCompleto.trim())),
                                              DataCell(Text(
                                                  persona['identificacion'])),
                                              DataCell(Text(data['estado'])),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

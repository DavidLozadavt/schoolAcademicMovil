import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
/*
class Student {
  final String name;
  final List<Grade> grades;

  Student(this.name, this.grades);
}

class Grade {
  final String subject;
  final double score;

  Grade(this.subject, this.score);
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  Student selectedStudent = Student('JOSE', [
    Grade('Matematicas', 5.0),
    Grade('Ingles', 4.0),
    Grade('Historia', 3.0),
  ]);

  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    double averageScore = _calculateAverageScore(selectedStudent);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.grey), 
                    
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset:
                        const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(30.0),
                
                  icon: const Icon(Icons.arrow_drop_down_sharp,
                      color: Colors.grey),
                  value: selectedSubject,
                  hint: const Text('Selecciona una materia'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubject = newValue;
                      _showSubjectDetails(newValue);
                    });
                  },
                  items: selectedStudent.grades.map((Grade grade) {
                    return DropdownMenuItem<String>(
                      value: grade.subject,
                      child: Text(grade.subject),
                    );
                  }).toList(),
                  style: const TextStyle(
                      color: Colors.black), // Especifica el estilo del texto
                  dropdownColor:
                      Colors.white, // Color de fondo del menú desplegable
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text('Mi promedio'),
            SizedBox(
              height: 300,
              width: 300,
              child: _buildPieChart(selectedStudent),
            ),
            const SizedBox(height: 20),
            Text(
              'Promedio de ${selectedStudent.name}: $averageScore',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Estas en el puesto 01/25'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSubjectDetails(String? subject) {
    if (subject != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detalles de $subject'),
            content: Text('En ejecución $subject.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  double _calculateAverageScore(Student student) {
    double totalScore = 0;
    for (var grade in student.grades) {
      totalScore += grade.score;
    }
    return totalScore / student.grades.length;
  }

  Widget _buildPieChart(Student student) {
    List<Grade> grades = student.grades;
    List<_ChartData> chartData = [];

    // Definir colores para cada materia
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      //Colors.yellow,
    ];

    grades.asMap().forEach((index, grade) {
      Color color = colors[index % colors.length];
      chartData.add(
          _ChartData('${grade.subject}: ${grade.score}%', grade.score, color));
    });

    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<_ChartData, String>(
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.subject,
          yValueMapper: (_ChartData data, _) => data.score,
          pointColorMapper: (_ChartData data, _) => data.color,
          dataLabelMapper: (_ChartData data, _) => data.subject,
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  final String subject;
  final double score;
  final Color color;

  _ChartData(this.subject, this.score, this.color);
}
*/
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Clases existentes
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
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  Student selectedStudent = Student('Edwin', [
    Grade('Matematicas', 5.0),
    Grade('Ingles', 4.0),
    Grade('Historia', 3.0),
  ]);

  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    double averageScore = _calculateAverageScore(selectedStudent);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(),
              ),
              child: DropdownButton<String>(
                icon: const Icon(Icons.arrow_drop_down_sharp),
                value: selectedSubject,
                hint: const Text('Selecciona una materia'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSubject = newValue;
                    _showSubjectDetails(newValue);
                  });
                },
                underline: Container(
                  height: 0.0,
                  color: Colors.transparent,
                ),
                items: selectedStudent.grades.map((Grade grade) {
                  return DropdownMenuItem<String>(
                    value: grade.subject,
                    child: Text(grade.subject),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      //  Colors.yellow,
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
            isVisible: true, // Asegura que las etiquetas de datos sean visibles
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

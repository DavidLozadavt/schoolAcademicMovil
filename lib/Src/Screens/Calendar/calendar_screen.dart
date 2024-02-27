import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vtschool/Src/Services/auth_service.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Map<String, dynamic>> _hourlyEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    String url = 'http://192.168.101.9:8000/api/materias/horario_materia';
    String token = await getToken();
    Map<String, dynamic> requestData = {
      'idPrograma': 2,
      'relations': [
        'infraestructura.sede',
        'dia',
        'materia.materia',
        'materia.grado.programa'
      ]
    };
    Uri uri = Uri.parse(url);
    Uri requestUri = uri
        .replace(queryParameters: {'data_encoded': json.encode(requestData)});

    final response = await http.get(
      requestUri,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final List<dynamic> decodedData = json.decode(response.body);
        final List<Map<String, dynamic>> events =
            List<Map<String, dynamic>>.from(decodedData);
        setState(() {
          _hourlyEvents = events;
        });
        print(_hourlyEvents);
      } else {
        print('La respuesta del servidor está vacía.');
      }
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 475,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Horario 📆📌'),
        ),
        body: SfCalendar(
          view: CalendarView.day,
          dataSource: _getDataSource(),
          onTap: _onTap,
        ),
      ),
    );
  }

  CalendarDataSource<Object?> _getDataSource() {
    List<Appointment> appointments = [];
    for (var event in _hourlyEvents) {
      DateTime startTime = DateTime.parse('2024-02-12 ${event["horaInicial"]}');
      DateTime endTime = DateTime.parse('2024-02-12 ${event["horaFinal"]}');

      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: '${event["materia"]["materia"]["nombreMateria"]}',
        color: _getEventColor(event["estado"]),
        id: event["id"].toString(),
      ));
    }

    return _DataSource(appointments);
  }

  Color _getEventColor(String estado) {
    switch (estado) {
      case "SIN ASIGNAR":
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  void _onTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final selectedEventId = details.appointments!.first.id;
      final selectedEvent = _hourlyEvents
          .firstWhere((event) => event["id"].toString() == selectedEventId);
      _showEventDetails(selectedEvent);
    }
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Detalle'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Materia: ${event["materia"]["materia"]["nombreMateria"]}'),
            Text('Sede: ${event["infraestructura"]["sede"]["nombreSede"]}'),
            Text('Hora Inicial: ${event["horaInicial"]}'),
            Text('Hora Final: ${event["horaFinal"]}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class _DataSource extends CalendarDataSource<Object?> {
  _DataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}

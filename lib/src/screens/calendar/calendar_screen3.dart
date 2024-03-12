import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/calendar/calendar_controller.dart';


class CalendarWrapper extends StatelessWidget {
  final CalendarController1 controller = Get.put(CalendarController1());

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: SizedBox(
        width: 400,
        height: 475,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Horario 📆📌'),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              return SfCalendar(
                view: CalendarView.day,
                dataSource: _getDataSource(controller.events),
                onTap: (details) => _onTap(context, details, controller.events),
              );
            }
          }),
        ),
      ),
    );
  }

 CalendarDataSource<Object?> _getDataSource(List<Map<String, dynamic>> hourlyEvents) {
  List<Appointment> appointments = [];
  for (var event in hourlyEvents) {
    DateTime startTime = DateTime.parse('2024-02-12 ${event["horaInicial"]}');
    DateTime endTime = DateTime.parse('2024-02-12 ${event["horaFinal"]}');

    appointments.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: '${event["nombreMateria"]}', 
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

  void _onTap(BuildContext context, CalendarTapDetails details, List<Map<String, dynamic>> hourlyEvents) {
    if (details.targetElement == CalendarElement.appointment) {
      final selectedEventId = details.appointments!.first.id;
      final selectedEvent = hourlyEvents
          .firstWhere((event) => event["id"].toString() == selectedEventId);
      _showEventDetails(context, selectedEvent);
    }
  }

  void _showEventDetails(BuildContext context, Map<String, dynamic> event) {
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


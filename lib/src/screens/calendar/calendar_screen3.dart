import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/calendar/calendar_controller.dart';

class Calendar extends StatelessWidget {
  final CalendarController1 controller = Get.put(CalendarController1());

  Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              return SfCalendar(
                firstDayOfWeek: 1,
                view: CalendarView.week,
                dataSource: _getDataSource(controller.events),
                onTap: (details) => _onTap(context, details, controller.events),
              );
            }
          }
    );
  }

  CalendarDataSource<Object?> _getDataSource(
      List<Map<String, dynamic>> hourlyEvents) {
    List<Appointment> appointments = [];
    for (var event in hourlyEvents) {
      var endTimeData = event["horarios"][0]["periodo"]["fechaFinal"];
      DateTime fecha = DateTime.parse(endTimeData);
      fecha = DateTime(fecha.year, fecha.month, fecha.day, 12, 0);
      String fechaFormateada =
          '${DateFormat('yyyyMMddTHHmmss').format(fecha)}Z';
      print('12 $fechaFormateada');
      DateTime startTime =
          DateTime.parse('${event["horarios"][0]["periodo"]["fechaInicial"]} ${event["horarios"][0]["horaInicial"]}');
      DateTime endTime =
          DateTime.parse('${event["horarios"][0]["periodo"]["fechaInicial"]} ${event["horarios"][0]["horaFinal"]}');
      var day = event["horarios"][0]['dia']['id'];
      String? dayOfWeek;
      if (day == 1) {
        dayOfWeek = 'BYDAY=MO';
      } else if (day == 2) {
        dayOfWeek = 'BYDAY=TU';
      } else if (day == 3) {
        dayOfWeek = 'BYDAY=WE';
      } else if (day == 4) {
        dayOfWeek = 'BYDAY=TH';
      } else if (day == 5) {
        dayOfWeek = 'BYDAY=FR';
      } else if (day == 6) {
        dayOfWeek = 'BYDAY=SA';
      } else if (day == 7) {
        dayOfWeek = 'BYDAY=SU';
      }

      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: '${event['horarios'][0]['materia']['materia']['nombreMateria']}',
        color: _getEventColor(event['horarios'][0]["estado"]),
        id: event["id"].toString(),
        recurrenceRule:
            'RRULE:FREQ=WEEKLY;$dayOfWeek;WKST=MO;UNTIL=$fechaFormateada',
      ));
    }
    return _DataSource(appointments);
  }

  Color _getEventColor(String estado) {
    switch (estado) {
      case "SIN ASIGNAR":
        return Colors.grey;
      case "PENDIENTE":
        return const Color.fromARGB(255, 252, 0, 0);
      default:
        return Colors.blue;
    }
  }

  void _onTap(BuildContext context, CalendarTapDetails details,
      List<Map<String, dynamic>> hourlyEvents) {
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
            Text('Materia: ${event['horarios'][0]["materia"]["materia"]["nombreMateria"]}'),
            Text('Sede: ${event['horarios'][0]["infraestructura"]["sede"]["nombreSede"]}'),
            Text('Hora Inicial: ${event['horarios'][0]["horaInicial"]}'),
            Text('Hora Final: ${event['horarios'][0]["horaFinal"]}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
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

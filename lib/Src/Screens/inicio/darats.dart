// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:vtschool/services/auth_service.dart';

// class Calendar extends StatefulWidget {
//   const Calendar({Key? key}) : super(key: key);

//   @override
//   _CalendarState createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
//   List<Map<String, dynamic>> _hourlyEvents = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchEvents();
//   }

//   Future<void> _fetchEvents() async {
//     String url = 'http://192.168.101.9:8000/api/materias/horario_materia';
//     String token = await getToken();
//     Map<String, dynamic> requestData = {
//       'idPrograma': 2,
//       'relations': [
//         'infraestructura.sede',
//         'dia',
//         'materia.materia',
//         'materia.grado.programa'
//       ]
//     };
//     Uri uri = Uri.parse(url);
//     Uri requestUri = uri
//         .replace(queryParameters: {'data_encoded': json.encode(requestData)});

//     final response = await http.get(
//       requestUri,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       if (response.body.isNotEmpty) {
//         final List<dynamic> decodedData = json.decode(response.body);
//         final List<Map<String, dynamic>> events =
//             List<Map<String, dynamic>>.from(decodedData);
//         setState(() {
//           _hourlyEvents = events;
//         });
//         print(_hourlyEvents);
//       } else {
//         print('La respuesta del servidor está vacía.');
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//       throw Exception('Failed to load events');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 400,
//       height: 475,
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Horario 📆📌'),
//           ),
//           body: ListView.builder(
//             itemCount: _hourlyEvents.length,
//             itemBuilder: (context, index) {
//               final event = _hourlyEvents[index];
//               final materia = event['materia']['materia']['nombreMateria'];
//               final nombreSede = event['infraestructura']['sede']['nombreSede'];
//               return ListTile(
//                 title: Text('Materia: $materia'),
//                 subtitle: Text('Sede: $nombreSede'),
//                 onTap: () {
//                   // Aquí puedes agregar lógica para manejar la interacción con el evento, como mostrar detalles adicionales
//                   // o realizar alguna acción específica.
//                 },
//               );
//             },
//           )),
//     );
//   }

//   void _showEventDetails(Appointment appointment) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Detalles del evento'),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Materia: ${appointment.subject}'),
//             Text('Hora Inicial: ${appointment.startTime}'),
//             Text('Hora Final: ${appointment.endTime}'),
//             // Agrega más detalles según tu modelo de datos
//           ],
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cerrar'),
//           ),
//         ],
//       ),
//     );
//   }

//   CalendarDataSource<Object?> _getDataSource() {
//     List<Appointment> appointments = [];

//     for (var event in _hourlyEvents) {
//       DateTime startTime = DateTime.parse('2024-02-12 ${event["horaInicial"]}');
//       DateTime endTime = DateTime.parse('2024-02-12 ${event["horaFinal"]}');

//       appointments.add(Appointment(
//         startTime: startTime,
//         endTime: endTime,
//         subject: 'Materia ${event["id"]}',
//         color: _getEventColor(event["estado"]),
//       ));
//     }

//     return _DataSource(appointments);
//   }

//   Color _getEventColor(String estado) {
//     switch (estado) {
//       case "SIN ASIGNAR":
//         return Colors.grey;
//       default:
//         return Colors.blue;
//     }
//   }

//   Widget appointmentBuilder(
//       BuildContext context, CalendarAppointmentDetails details) {
//     final Appointment appointment = details.appointments!.first;
//     return Container(
//       decoration: BoxDecoration(
//         color: appointment.color,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Center(
//         child: Text(
//           appointment.subject,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

// class _DataSource extends CalendarDataSource<Object?> {
//   _DataSource(List<Appointment> appointments) {
//     this.appointments = appointments;
//   }
// }

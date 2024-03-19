/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/calendar/calendar_controller.dart';


class CalendarView extends StatelessWidget {
 
  final CalendarController1 controller = Get.put(CalendarController1(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de Eventos'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              final event = controller.events[index];
              return ListTile(
                title: Column(
                  children: [
                      Text('Evento: ${event['id']}'),
                      Text('HoraInicial: ${event['horaInicial']}'),
                      Text('HoraFinal: ${event['horaFinal']}'),
                      Text('Materia: ${event['materia']['materia']['nombreMateria']}'),
                      Image.network('${event['infraestructura']['sede']['rutaImagenUrl']}'),
                  ],
                ),
                subtitle: Column(
                  children: [
                     Text('Fecha: ${event['fechaInicial']}'),
                  ],
                ),
               
              );
            },
          );
        }
      }),
    );
  }
}
*/
import 'dart:convert';

import 'package:get/get.dart';

import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class SubjectProvider extends GetConnect {
  final AuthProvider authProvider = AuthProvider();
  var subject = <Map<String, dynamic>>[].obs;

  Future<void> getSubject(
    String idWorkingDay,
    String idSubject,
    String idProgram,
    String startTime,
    String endTime,
    int idSchedule
  ) async {
    String token = await authProvider.getToken();
    dynamic data = {
      "idJornada": idWorkingDay,
      "idMateria": idSubject,
      "idPrograma": idProgram,
      "horaInicial": startTime,
      "horaFinal": endTime,
      "idHorario": idSchedule
    };

    String jsonData = jsonEncode(data);
   // print('a12346 $jsonData');
    Response response = await get(
      '$getStudentByIdMateriaUrl$jsonData',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
   print('20000000000000000 ${response.body}');
    if (response.statusCode == 200) {
     if (response.body is List) {
        // Si la respuesta es una lista
        subject.assignAll((response.body as List).cast<Map<String, dynamic>>());
      } else if (response.body is Map) {
        // Si la respuesta es un solo objeto
        subject.assignAll([response.body as Map<String, dynamic>]);
      } else {
        throw Failure('El formato de la respuesta no es compatible');
      }
    } else {
      throw Failure('Error al cargar la información');
    }
  }

  Future<void> readNotifications(String id) async {
    String token = await authProvider.getToken();

    Response response = await put(
      '$putReadNotificationsUrl$id',
      {},
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }
}

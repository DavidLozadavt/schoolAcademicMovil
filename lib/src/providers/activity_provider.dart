import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/models/api_assigned_activities.dart';
import 'package:vtschool/src/models/api_response_activities_registrations_model.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ActivityProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();
  var activitiesStudent = <Map<String, dynamic>>[].obs;
  var activitiesById = <Map<String, dynamic>>[].obs;
  var allActivitiesById = <Map<String, dynamic>>[].obs;
  var questionnaireActivity = <Map<String, dynamic>>[].obs;
  var getTypeActivitiesById = <Map<String, dynamic>>[].obs;

  var tituloActividad = ''.obs;
  var descripcionActividad = ''.obs;
  var archivo = Rxn<File>();

  Future<void> getActivitiesStudent() async {
    String token = await authService.getToken();
    Response response = await get(
      getActivitiesStudentUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      //Map<String, dynamic> responseBody = response.body;
      /*if (responseBody.isNotEmpty) {*/
      activitiesStudent.assignAll(response.body.cast<Map<String, dynamic>>());
      /*  } else {
          throw Failure('La respuesta del servidor está vacía.');
        }*/
    } else if (response.statusCode == 400) {
      activitiesStudent.assignAll([]);
    } else {
      throw Failure('Error al cargar las actividades');
    }
  }

  Future<void> getActivityById(String? id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getActivityByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      /*if (responseBody.isNotEmpty) {*/
      activitiesById.assignAll([responseBody]);
      /*  } else {
          throw Failure('La respuesta del servidor está vacía.');
        }*/
    } else {
      throw Failure('Error al cargar las actividades');
    }
  }

  Future<void> createActivityProvider(
  String id,
  String titulo,
  String descripcion,
  File? archivo,
) async {
  try {
    String token = await authService.getToken();
    String url = '$createActivitiesUrl$id';
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields['tituloActividad'] = titulo;
    request.fields['descripcionActividad'] = descripcion;
    request.fields['idTipoActividad'] = '2';
    request.headers['Authorization'] = 'Bearer $token';
    if (archivo != null) {
      String fileName = basename(archivo.path);
      request.files.add(
        await http.MultipartFile.fromPath(
          'pathDocumentoActividadFile',
          archivo.path,
          filename: fileName,
        ),
      );
    }

    // Enviar la solicitud
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      String responseBody = await response.stream.bytesToString();
      throw Exception('No se pudo crear la actividad: $responseBody');
    }
  } catch (e) {
    throw Exception('Ocurrió un error: $e');
  }
}


  Future<Map<String, dynamic>> getTypeActivity(String? id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getTypeActivityUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.body;
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }

  Future<Map<String, dynamic>> getActivityQuestionnaire(String? id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getActivityQuestionnaireUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.body;
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }

  Future<void> replyActivity(String id, String? comment, File? file) async {
    String token = await authService.getToken();
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$postReplyActivityUrl$id'));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';

      if (comment != null) {
        request.fields['ComentarioEstudiante'] = comment;
      }
      if (file != null) {
        request.files.add(http.MultipartFile(
            'archivoFile', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split('/').last));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      //('Response status: ${response.statusCode}');
      //('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Error al enviar la respuesta: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al enviar la respuesta: $e');
    }
  }

  Future<Map<String, dynamic>> replyQuestionnaire(
      String idQualification, dynamic answers) async {
    dynamic answersJson = jsonEncode(answers);
    String token = await authService.getToken();
    print('877777777 $answersJson');
    try {
      Response response = await post(
        '$postReplyQuestionnaireUrl$idQualification',
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
        contentType: 'application/json',
        answersJson,
      );
      print('770999 ${response.body}');
      if (response.statusCode == 401) {
        throw Failure('Otro');
      }
      if (response.statusCode != 200) {
        throw Failure('Algo salió mal, vuelve a intentarlo');
      }
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('¡OK!', 'Respondiste tu cuestionario');
        if (response.body.isNotEmpty) {
          return response.body;
        } else {
          throw Failure('La respuesta del servidor está vacía.');
        }
      }
    } catch (e) {
      throw Failure('$e');
    }
    throw Exception('Error: La función no devolvió un valor');
  }

  /*Future<void> replyQuestionnaire1(
      String idQualification, dynamic answers) async {
    dynamic answersJson = jsonEncode(answers);
    String token = await authService.getToken();
    print(answersJson);
    try {
      Response response = await post(
        '$postReplyQuestionnaire1Url$idQualification',
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
        contentType: 'application/json',
        answersJson,
      );
      if (response.statusCode == 401) {
        throw Failure('Otro');
      }
      if (response.statusCode != 200) {
        throw Failure('Algo salió mal, vuelve a intentarlo');
      }
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('¡OK!', 'Respondiste tu cuestionario');
      }
    } catch (e) {
      throw Failure('$e');
    }
  }*/

  //Actividades por id de materia

  Future<void> getActivitiesById1(String? id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getActivitiesByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    (response.body);
    if (response.statusCode == 200) {
      /*if (responseBody.isNotEmpty) {*/
      allActivitiesById.assignAll(response.body);
      /*  } else {
          throw Failure('La respuesta del servidor está vacía.');
        }*/
    } else {
      throw Failure('Error al cargar las actividades');
    }
  }

  Future<List<Actividad>> getActivitiesById(String? id) async {
    String token = await authService.getToken();
    final response = await get(
      '$getActivitiesByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    (response.body);
    if (response.statusCode == 200) {
      return (response.body as List)
          .map((activity) => Actividad.fromJson(activity))
          .toList();
    } else {
      throw Failure('Error al cargar las actividades');
    }
  }

  Future<List<AssignedActivities>> getActivitiesByTeacher(String? id) async {
    String token = await authService.getToken();
    final response = await get(
      '$assignedActivitiesUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    (response.body);
    if (response.statusCode == 200) {
      return (response.body as List)
          .map((activity) => AssignedActivities.fromJson(activity))
          .toList();
    } else {
      throw Failure('Error al cargar las actividades');
    }
  }

  Future<List<Registrationsactivity>> fetchActivitiesRegistrations(activityId,
      {groupId}) async {
    String token = await authService.getToken();

    Map<String, String> queryParameters = {};
    if (groupId != null) {
      queryParameters['idGrupo'] = groupId.toString();
    }

    final url = Uri.parse('$activityByregistrationUrl$activityId').replace(
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Registrationsactivity> activities =
          registrationsactivityFromJson(json.encode(data));
      return activities;
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

  Future<void> rateActivity(int idCalificacion, String comentarioDocente,
      String calificacionNumerica) async {
    final url = '$rateActivityUrl$idCalificacion';
    String token = await authService.getToken();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ComentarioDocente': comentarioDocente,
          'calificacionNumerica': calificacionNumerica,
        }),
      );

      if (response.statusCode == 200) {
        ('Datos enviados correctamente');
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception(responseBody['message'] ?? 'Error desconocido');
      }
    } catch (e) {
      rethrow;
    }
  }

  //eliminarActividades
  Future<void> deleteActivityById(String id) async {
    String token = await authService.getToken();

    final response = await delete(
      '$deleteActivitiesUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      ('Actividad eliminada correctamente');
    } else {
      throw Failure('No se puede eliminar una actividad asignada');
    }
  }

  ///asistencia
  Future<void> attendance({dynamic data}) async {
    String token = await authService.getToken();

    Response response = await put(
      putAttendanceUrl,
      {data},
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

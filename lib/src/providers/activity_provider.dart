import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ActivityProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();
  var activitiesById = <Map<String, dynamic>>[].obs;
  var questionnaireActivity = <Map<String, dynamic>>[].obs;
  var getTypeActivitiesById = <Map<String, dynamic>>[].obs;

  Future<void> getActivityById(String? id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getActivityByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print('2024 ${response.body}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        activitiesById.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Error al enviar la respuesta: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al enviar la respuesta: $e');
    }
  }

  Future<void> replyQuestionnaire(
      String idQualification, dynamic answers) async {

    dynamic answersJson = jsonEncode(answers);
    String token = await authService.getToken();
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
  }

  Future<void> replyQuestionnaire1(
      String idQualification, dynamic answers) async {

    dynamic answersJson = jsonEncode(answers);
    String token = await authService.getToken();
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
  }
}

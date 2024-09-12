import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ChatProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();
  var users = <Map<String, dynamic>>[].obs;
  var messages = <Map<String, dynamic>>[].obs;

  Future<void> getUsersByUser() async {
    String token = await authService.getToken();
    Response response = await get(
      getUsersByUserUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    // print('code .${response.statusCode}');
    // print('body .${response.body}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        users.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía');
      }
    } else {
      throw Failure('Error al cargar los usuarios');
    }
  }

  Future<void> getMessage(String idUserSelected) async {
    String token = await authService.getToken();
    Map<String, dynamic> data = {
    "relations": [
      "activeCompanyUser.user.persona",
      "asignaciones"
    ]
  };
  String jsonString = jsonEncode(data);
  //  print('88888 $jsonString');
    //   print('9999 $idUserSelected');
    Response response = await get(
      '$getMessagesUserUrl$idUserSelected?data=$jsonString',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    //print('77777 ${response.body}');
    //print('11111 ${response.statusCode}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        messages.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía');
      }
    } else {
      throw Failure('Error al cargar los mensajes');
    }
  }

  Future<Map<String, dynamic>> sendMessage(
      String idUserSelected, String message, List<File>? archivos) async {
    String token = await authService.getToken();

    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            '$postMessagesUserUrl$idUserSelected/comments',
          ));
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['body'] = message;
      request.fields['origen'] = 'MOBILE';

      if (archivos![0].path.isNotEmpty) {
        for (var i = 0; i < archivos.length; i++) {
          var archivo = archivos[i];
          request.files.add(http.MultipartFile('archivos[$i]',
              archivo.readAsBytes().asStream(), archivo.lengthSync(),
              filename: archivo.path.split('/').last));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          return {};
        }
      } else {
        throw Exception('Error al enviar el mensaje');
      }
    } catch (e) {
      throw Exception('Error al enviar el mensaje');
    }
  }
}

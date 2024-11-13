import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/providers/auth_provider.dart';
class SupportProvider extends GetConnect {
   final AuthProvider authService = AuthProvider();
   Future<void> sendSupport(String? comment, File? file) async {
    String token = await authService.getToken();
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(postSupportUrl));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';

      if (comment != null) {
        request.fields['comment'] = comment;
      }
      if (file != null) {
        request.files.add(http.MultipartFile(
            'fileSupport', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split('/').last));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('Response1 ${request.fields}');
      print('Response2 ${request.files}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Get.back();
         Get.snackbar("Éxito", "Se ha enviado a soporte");
      }
    } catch (e) {
      throw Exception('Error al enviar la respuesta: $e');
    }
  }
}
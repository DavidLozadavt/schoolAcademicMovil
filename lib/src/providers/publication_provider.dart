import 'dart:io';

import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/models/api_response_publications.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class PublicationProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();

  Future<List<Publicacion>> getPublications() async {
    String token = await authService.getToken();

    final response = await get(
      publicationsUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> body = response.body;
      List<Publicacion> publicaciones =
          body.map((item) => Publicacion.fromJson(item)).toList();
      return publicaciones;
    } else {
      throw Exception('Error al obtener publicaciones: ${response.statusText}');
    }
  }

    Future<void> createPublication(File singleFile, List<File> multipleFiles, String description) async {
    String token = await authService.getToken();
        final form = FormData({
      'description': description,
      'file': MultipartFile(singleFile, filename: singleFile.path.split('/').last),
      'images[]': multipleFiles.map((file) => MultipartFile(file, filename: file.path.split('/').last)).toList(),
    });
    
    final response = await post(
      publicationsUrl,
      form,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      print('Publicación creada exitosamente');
    } else {
      throw Exception('Error al crear la publicación: ${response.statusText}');
    }
  }

}

import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/models/api_response_publications.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class PublicationProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();

  Future<List<Publicacion>> getPublications() async {
    String token = await authService.getToken();

    final response = await get(
      getPublicationsUrl,
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


  
}

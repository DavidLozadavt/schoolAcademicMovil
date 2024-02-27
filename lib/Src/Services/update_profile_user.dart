import 'dart:convert';
import 'package:vtschool/Src/Api/constant.dart';
import 'package:vtschool/Src/Models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:vtschool/Src/Models/auth_user_model.dart';
import 'package:vtschool/Src/Services/auth_service.dart';

Future<ApiResponse> updateProfile({
  String? nombre1,
  String? nombre2,
  String? apellido1,
  String? apellido2,
  String? idCiudadUbicacion,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    Map<String, dynamic> requestBody = {};

    if (nombre1 != null) requestBody["nombre1"] = nombre1;
    if (nombre2 != null) requestBody["nombre2"] = nombre2;
    if (apellido1 != null) requestBody["apellido1"] = apellido1;
    if (apellido2 != null) requestBody["apellido2"] = apellido2;
    if (idCiudadUbicacion != null) requestBody["idCiudadUbicacion"] = idCiudadUbicacion;


    http.Response response = await http.post(Uri.parse(urlUpdateProfile),
        headers: {
         
          'Authorization': 'Bearer $token'
        },
        body: requestBody);

        print('RequestBody: $requestBody');


    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
    print('Response status code: ${response.statusCode}');

  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}


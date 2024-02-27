import 'dart:convert';
import 'package:vtschool/Src/Api/constant.dart';
import 'package:vtschool/Src/Models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:vtschool/Src/Models/message_service_model.dart';
import 'package:vtschool/Src/Models/services_model.dart';
import 'package:vtschool/Src/Services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Pedir un servicio
Future<ApiResponse> service(int idEmpresa, String direccion, String barrio,
  String numeroCelular, String? observacion) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    Map<String, dynamic> requestBody = {
      "idEmpresa": idEmpresa,
      "ubicacionTelefono": {
        "ubicacion": {
          "direccion": direccion,
          "barrio": {"nombre": barrio}
        },
        "telefono": {"idTipoTelefono": 1, "numeroTelefono": numeroCelular}
      }
    };

    if (observacion != null) {
      requestBody["observaciones"] = observacion;
    }

    http.Response response = await http.post(Uri.parse(urlServiceByUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(requestBody));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('responseMap', response.body);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = CRequestService.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 400:
        apiResponse.error = 'Servicio en espera';
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
  } catch (e) {
    if (e.toString().isNotEmpty && observacion!.isEmpty) {
      apiResponse.error;
    } else if (e.toString().isNotEmpty && observacion!.isNotEmpty) {
      apiResponse.error;
    } else {
      apiResponse.error = serverError;
    }
  }
  return apiResponse;
}

//cancelar un servicio
Future<ApiResponse> cancelarService() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(cancelarServiceUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = CRequestService.fromJson(jsonDecode(response.body));
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
      case 404:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}


Future<ApiResponse> postMessageService(String body) async {
  ApiResponse apiResponse = ApiResponse();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? responseBody = pref.getString('responseMap');
  Map<String, dynamic> jsonMap = json.decode(responseBody.toString());
  int idService = jsonMap['id'];
  try {
    final response = await http.post(
      Uri.parse('$postMessageURL$idService'),
      headers: {'Accept': 'application/json'},
      body: {
        'body': body,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = MesaggeService.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}


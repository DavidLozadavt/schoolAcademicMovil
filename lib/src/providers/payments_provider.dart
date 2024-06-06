import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class WompiProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();

  Future<Map<String, dynamic>> getFinancialInstitutions() async {
    String token = await authService.getToken();
    Response response = await get(
      getFinancialInstitutionsUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    //print('getFinancialInstitutions ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.body;
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar las instituciones');
    }
  }

  Future<Map<String, dynamic>> sendTransactionPse(dynamic data) async {
    String token = await authService.getToken();
    Response response = await post(
      postTransactionPseUrl,
      data,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    //print('sendTransactionPse ${response.statusCode}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.body;
      } else {
        throw Failure('La respuesta del servidor está vacía');
      }
    } else {
      throw Failure('Error al enviar los datos de PSE');
    }
  }

   Future<Map<String, dynamic>> getFindTransactionById(String id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getFindTransactionByIdUrl$id',
      contentType: 'application/json',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    //print('getFindTransactionById ${response.body}');
    debugPrint('getFindTransactionById ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.body['data'];
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar la informacion de la transaccion');
    }
  }

}

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
    print('getFinancialInstitutions ${response.body}');

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
    print('sendTransactionPse ${response.statusCode}');
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
    print('getFindTransactionById ${response.body}');

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



Future<Map<String, dynamic>> getFindTransactionById2(String id) async {
  String token = await authService.getToken();
  final url = '$getFindTransactionByIdUrl$id';
  final headers = {
    'Authorization': 'Bearer $token',
    'accept': 'application/json',
  };

  final response = await http.get(Uri.parse(url), headers: headers);

  // Imprime la respuesta completa para verificarla
  print('Respuesta completa: ${response.body}');

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;

      // Verifica que los campos necesarios están presentes y no son nulos
      if (decodedResponse.containsKey('data') && decodedResponse['data'] != null) {
        Map<String, dynamic> data = decodedResponse['data'];
        
        // Imprime todos los datos recibidos para verificar la estructura
        data.forEach((key, value) {
          print('Clave: $key, Valor: $value');
        });

        Map<String, dynamic> paymentMethod = data['payment_method'];

        // Imprime el contenido de paymentMethod para verificarlo
        print('Contenido de paymentMethod: $paymentMethod');

        if (paymentMethod.containsKey('extra') && paymentMethod['extra'] != null) {
          // Imprime el contenido de extra para verificarlo
          print('Contenido de extra: ${paymentMethod['extra']}');

          if (paymentMethod['extra'].containsKey('async_payment_url')) {
            String asyncPaymentUrl = paymentMethod['extra']['async_payment_url'];
            print('El valor de async_payment_url es: $asyncPaymentUrl');
          } else {
            print('El campo "async_payment_url" no está presente en "extra"');
          }
        } else {
          print('El campo "extra" no está presente o es nulo');
        }
      } else {
        print('El campo "data" no está presente o es nulo');
      }

      return decodedResponse;
    } else {
      throw Failure('La respuesta del servidor está vacía.');
    }
  } else {
    throw Failure('Error al cargar la informacion de la transaccion');
  }
}

Future<Map<String, dynamic>> getFindTransactionById5(String id) async {
  String token = await authService.getToken();
  final url = '$getFindTransactionByIdUrl$id';
  final headers = {
    'Authorization': 'Bearer $token',
    'accept': 'application/json',
  };

  final response = await http.get(Uri.parse(url), headers: headers);

  print('Status Code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Content-Length: ${response.contentLength}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      try {
        final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
        print('Decoded Response: $decodedResponse');

        if (decodedResponse.containsKey('data') && decodedResponse['data'] != null) {
          Map<String, dynamic> data = decodedResponse['data'];
          print('Data: $data');

          if (data.containsKey('payment_method') && data['payment_method'] != null) {
            Map<String, dynamic> paymentMethod = data['payment_method'];
            print('Payment Method: $paymentMethod');

            if (paymentMethod.containsKey('extra') && paymentMethod['extra'] != null) {
              Map<String, dynamic> extra = paymentMethod['extra'];
              print('Extra: $extra');

              if (extra.containsKey('async_payment_url')) {
                String asyncPaymentUrl = extra['async_payment_url'];
                print('Async Payment URL: $asyncPaymentUrl');
              } else {
                print('The "async_payment_url" field is missing in "extra".');
              }
            } else {
              print('The "extra" field is missing or null in "payment_method".');
            }
          } else {
            print('The "payment_method" field is missing or null in "data".');
          }
        } else {
          print('The "data" field is missing or null.');
        }

        return decodedResponse;
      } catch (e) {
        print('Error decoding response: $e');
        throw Exception('Error decoding response');
      }
    } else {
      print('The server response is empty.');
      throw Exception('The server response is empty.');
    }
  } else {
    print('Error fetching transaction information.');
    throw Exception('Error fetching transaction information.');
  }
}

}

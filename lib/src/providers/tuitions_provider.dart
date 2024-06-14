import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class TuitionsProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();
 
  var tuitionPayments = <Map<String, dynamic>>[].obs;
  var inscriptionPayments = <Map<String, dynamic>>[].obs;

  Future<void> getTuitionPayments() async {
    String token = await authService.getToken();
    Response response = await get(
      '$getTuitionPaymentAllowanceUrl?data_encoded={"relations":["configuracionPago","proceso"]}',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print('2025fff ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        tuitionPayments.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los pagos');
    }
  }

  Future<void> getInscriptionPayments() async {
    String token = await authService.getToken();
    Response response = await get(
      '$getInscriptionPaymentUrl?data_encoded={"relations":["configuracionPago","proceso"]}',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print('2026fff ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        inscriptionPayments.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los pagos');
    }
  }

}

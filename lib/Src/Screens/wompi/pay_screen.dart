import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  final String _wompiPaymentUrl = 'https://sandbox.wompi.co/v1/transactions';
  final String token = 'pub_test_JvrqVoAm0JPXOUL42ioVLJWF86N9bANx';

  
Future<void> enviarDatos() async {
  var url = Uri.parse('https://sandbox.wompi.co/v1/transactions');

  // JSON que deseas enviar
  var json = '''
    {
    "acceptance_token":"eyJhbGciOiJIUzI1NiJ9.eyJjb250cmFjdF9pZCI6MTQyLCJwZXJtYWxpbmsiOiJodHRwczovL3dvbXBpLmNvbS9hc3NldHMvZG93bmxvYWRibGUvcmVnbGFtZW50by1Vc3Vhcmlvcy1Db2xvbWJpYS5wZGYiLCJmaWxlX2hhc2giOiJlZjAzZDVlZTZiM2YxNWMzY2Q0MDJkN2MxZDgwZTJmYyIsImppdCI6IjE3MDc4NTY1ODItNjU0MTYiLCJlbWFpbCI6IiIsImV4cCI6MTcwNzg2MDE4Mn0.I9DyUjANuSZoDPrLAQJhiy1Zcb2MKO-e3BYVF4ZZgKM",
    "amount_in_cents":150000,
    "currency":"COP",
    "customer_email":"edwinledezma201@gmail.com",
    "reference":"addv",
    "customer_data": { 
        "legal_id":"100292335",
        "full_name":"Edwin Ledeza",
        "phone_number":"3126185281",
        "legal_id_type":"CC"
    },
    "payment_method":
    {
        "type":"BANCOLOMBIA_TRANSFER",
        "user_type":"PERSON",
        "payment_description":"Pago de pruebas",
        "sandbox_status":"APPROVED"
    }


}
  ''';

  // Encabezados de la solicitud
  var headers = {
   'Authorization': 'Bearer $token',
  };


  var respuesta = await http.post(
    url,
    headers: headers,
    body: json,
  );

  if (respuesta.statusCode == 200) {
    print('Solicitud exitosa: ${respuesta.body}');
  } else {
    print('Error al enviar la solicitud: ${respuesta.statusCode}');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Transacción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                enviarDatos();
              },
              child: Text('Realizar Transacción'),
            ),
          ],
        ),
      ),
    );
  }
}

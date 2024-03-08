import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/models/ciudad_model.dart';
import 'package:vtschool/src/models/user_profile_model.dart';

Future<List<Ciudad>> fetchCiudades() async {
  final response = await http.get(Uri.parse(urlCiudad));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Ciudad.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load ciudades');
  }
}

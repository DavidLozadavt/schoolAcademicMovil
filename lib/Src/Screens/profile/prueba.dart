import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vtschool/Src/Services/auth_service.dart';

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  Map<String, dynamic> userData = {};
  final String apiUrl = 'http://192.168.101.9:8000/api/auth/user_data';
  // Replace with your actual auth token

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(apiUrl);

    try {
      String token = await getToken();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body);
        });
      } else {
        // Handle error
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User ID: ${userData['userData']['id']}'),
            Text('Email: ${userData['userData']['email']}'),
            Text('First Name: ${userData['userData']['persona']['nombre1']}'),
            Text('Last Name: ${userData['userData']['persona']['apellido1']}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}

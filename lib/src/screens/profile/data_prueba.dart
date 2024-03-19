/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vtschool/src/api/constant.dart';
import 'dart:convert';

import 'package:vtschool/src/providers/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userData = '';
  Map<String, dynamic> _userProfile = {};
   final AuthProvider authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
   String token = await authProvider.getToken();

    try {
      final response = await http.get(
        Uri.parse('${baseURL}auth/user_data'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> userDataMap = json.decode(response.body);
        setState(() {
          _userProfile = userDataMap['userData']['persona'];
        });
      } else {
        setState(() {
          _userData = 'Failed to load user data';
        });
      }
    } catch (error) {
      setState(() {
        _userData = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Detalles de Usuario',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildProfileItem('Nombre: ', _userProfile['nombre1']),
              _buildProfileItem('Apellido: ', _userProfile['apellido1']),
              _buildProfileItem('Correo Electrónico: ', _userProfile['email']),
              _buildProfileItem('Teléfono: ', _userProfile['telefonoFijo']),
              _buildProfileItem('Celular: ', _userProfile['celular']),
              _buildProfileItem('Dirección: ', _userProfile['direccion']),
              _buildProfileItem('Fecha de Nacimiento: ', _userProfile['fechaNac']),
              _buildProfileItem('Perfil: ', _userProfile['perfil']),
              _buildProfileItem('Sexo: ', _userProfile['sexo']),
              _buildProfileItem('Tipo de Sangre: ', _userProfile['rh']),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _fetchUserData,
                child: const Text('Actualizar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/



 
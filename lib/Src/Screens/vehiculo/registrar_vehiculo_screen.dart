import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:vtschool/Src/Services/auth_service.dart';

class VehiculoForm extends StatefulWidget {
  const VehiculoForm({super.key});

  @override
  _VehiculoFormState createState() => _VehiculoFormState();
}

class _VehiculoFormState extends State<VehiculoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController placaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  late File fotoFile;
  bool _imageSelected = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var vehiculoData = {
        'placa': placaController.text,
        'color': colorController.text,
        'modelo': modeloController.text,
        'marca': marcaController.text,
      };

      try {
        String token = await getToken();

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://192.168.101.8:8001/api/store_vehiculo'),
        );

        request.fields.addAll(vehiculoData);

        request.files.add(
          await http.MultipartFile.fromPath('rutaFotoFile', fotoFile.path),
        );
        request.headers.addAll({
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print('Respuesta del servidor: $responseString');

        // Mostrar el AlertDialog si el registro fue exitoso
        if (response.statusCode == 200) {
          await Future.delayed(const Duration(seconds: 4));
          _showSuccessDialog();
        } else {
          // Mostrar SnackBar en caso de error
          _showErrorSnackBar('Error al enviar el formulario');
        }
      } catch (error) {
        print('Error al enviar la solicitud: $error');
        // Mostrar SnackBar en caso de error
        _showErrorSnackBar('Error al enviar el formulario');
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text('El vehículo se ha registrado con éxito.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        fotoFile = File(pickedFile.path);
        _imageSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Vehículo'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: placaController,
                decoration: const InputDecoration(
                  labelText: 'Placa',
                  icon: Icon(Icons.directions_car),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la placa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                controller: colorController,
                decoration: const InputDecoration(
                  labelText: 'Color',
                  icon: Icon(Icons.color_lens),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el color';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                controller: modeloController,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  icon: Icon(Icons.confirmation_number),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el modelo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                controller: marcaController,
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  icon: Icon(Icons.branding_watermark),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la marca';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 3.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Seleccionar Foto'),
              ),
              const SizedBox(height: 3.0),
              _imageSelected
                  ? Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(fotoFile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 1.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtschool/src/screens/posts/posts_controller.dart';

class CrearPublicacionScreen extends StatefulWidget {
  @override
  _CrearPublicacionScreenState createState() => _CrearPublicacionScreenState();
}

class _CrearPublicacionScreenState extends State<CrearPublicacionScreen> {
  final PublicacionesController publicacionesController = Get.find<PublicacionesController>();
  final descriptionController = TextEditingController();
  File? coverImage;
  List<File> secondaryImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Publicación'),
        backgroundColor: const Color(0xFFFFDC4A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              Text('Imagen de Portada', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  File? image = await _seleccionarImagen(context);
                  if (image != null) {
                    setState(() {
                      coverImage = image; // Actualiza el estado de coverImage
                    });
                  }
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: coverImage != null 
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(coverImage!, fit: BoxFit.cover, width: double.infinity),
                        ) 
                      : const Center(child: Text('Toca aquí para seleccionar imagen de portada')),
                ),
              ),
              const SizedBox(height: 20),
              Text('Imágenes Secundarias', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var image in secondaryImages)
                    GestureDetector(
                      onTap: () {
                        // Lógica para eliminar la imagen (opcional)
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Image.file(image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () async {
                      List<File>? seleccionadas = await _seleccionarVariasImagenes(context);
                      if (seleccionadas != null) {
                        setState(() {
                          secondaryImages.addAll(seleccionadas); // Actualiza el estado de secondaryImages
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Center(child: Text('+')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (coverImage != null && descriptionController.text.isNotEmpty) {
                    publicacionesController.createPublicacion(
                      coverImage!,
                      secondaryImages,
                      descriptionController.text,
                    );
                    Navigator.of(context).pop(); // Regresar a la pantalla anterior
                  }
                },
                child: const Text('Publicar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<File?> _seleccionarImagen(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  Future<List<File>?> _seleccionarVariasImagenes(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    return images?.map((xFile) => File(xFile.path)).toList();
  }
}

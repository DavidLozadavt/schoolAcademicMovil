import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vtschool/src/screens/posts/posts_controller.dart';

class CrearPublicacionScreen extends StatefulWidget {
  @override
  _CrearPublicacionScreenState createState() => _CrearPublicacionScreenState();
}

class _CrearPublicacionScreenState extends State<CrearPublicacionScreen> {
  final PublicacionesController publicacionesController =
      Get.find<PublicacionesController>();
  final descriptionController = TextEditingController();
  File? coverImage;
  List<File> secondaryImages = [];
  bool _isLoading = false;

  void _mostrarDialogoCargando(String mensaje) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(mensaje),
            ],
          ),
        );
      },
    );
  }

  Future<void> _crearPublicacion() async {
    _mostrarDialogoCargando('Creando publicación...');
    try {
      await publicacionesController.createPublicacion(
        coverImage!,
        secondaryImages,
        descriptionController.text,
      );

      // Cambiar el mensaje a "Publicación creada"
      Navigator.of(context).pop(); // Cerrar el diálogo de carga
      _mostrarDialogoCargando('Publicación creada');

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Cerrar el diálogo y regresar
        Navigator.of(context).pop(); // Regresar a la pantalla anterior
      });
    } catch (e) {
      Navigator.of(context)
          .pop(); // Cerrar el diálogo de carga en caso de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear la publicación')),
      );
    }
  }

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
              Text('Imagen de Portada',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  File? image = await seleccionarImagen(context);
                  if (image != null) {
                    setState(() {
                      coverImage = image;
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
                          child: Image.file(coverImage!,
                              fit: BoxFit.cover, width: double.infinity),
                        )
                      : const Center(
                          child: Text(
                              'Toca aquí para seleccionar imagen de portada')),
                ),
              ),
              const SizedBox(height: 20),
              Text('Imágenes Secundarias',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      List<File>? seleccionadas =
                          await _seleccionarVariasImagenes(context);
                      if (seleccionadas != null) {
                        setState(() {
                          secondaryImages.addAll(seleccionadas);
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
                      child: const Center(
                          child: Text('+', style: TextStyle(fontSize: 24))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (coverImage != null &&
                        descriptionController.text.isNotEmpty) {
                      await _crearPublicacion(); // Ejecutar el método para crear la publicación
                    }
                  },
                  child: const Text('Publicar'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color(0xFFFFDC4A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Future<File?> seleccionarImagen(BuildContext context) async {
  var status = await Permission.photos.status;
  if (!status.isGranted) {
    await Permission.photos.request();
  }

  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) {
    // Show   
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al seleccionar imagen')),
    );
    return null;
  }
  return File(image.path);
}


  Future<List<File>?> _seleccionarVariasImagenes(BuildContext context) async {
  var status = await Permission.photos.status;
  if (!status.isGranted) {
    await Permission.photos.request();
  }

  if (!status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permiso de almacenamiento denegado')),
    );
    return null;
  }

  final ImagePicker picker = ImagePicker();
  final List<XFile>? images = await picker.pickMultiImage();
  return images?.map((xFile) => File(xFile.path)).toList();
}
}

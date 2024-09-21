import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/posts/posts_controller.dart';

class PostsScreen extends StatelessWidget {
  final PublicacionesController publicacionesController =
      Get.put(PublicacionesController());

  PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('EduBook',
            style: TextStyle(
                color: Colors.grey[800], fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blueAccent),
            onPressed: () {
              _mostrarFormularioPublicacion(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (publicacionesController.publicaciones.isEmpty) {
                return Center(
                  child: Text(
                    'No hay publicaciones aún',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                itemCount: publicacionesController.publicaciones.length,
                itemBuilder: (context, index) {
                  var publicacion =
                      publicacionesController.publicaciones[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    publicacion.user.persona.rutaFoto),
                                radius: 25,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    publicacion.user.persona.nombre1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '${publicacion.fechaPublicacion.day}/${publicacion.fechaPublicacion.month}/${publicacion.fechaPublicacion.year}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            publicacion.description,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[800]),
                          ),
                          if (publicacion.urlImage.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 450,
                              child: PageView.builder(
                                itemCount: 1, // Cambia esto si tienes varias imágenes
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      publicacion.urlImage,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _mostrarFormularioPublicacion(BuildContext context) {
    final autorController = TextEditingController();
    final contenidoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Nueva Publicación',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: autorController,
                decoration: InputDecoration(
                  labelText: 'Autor',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contenidoController,
                decoration: InputDecoration(
                  labelText: 'Contenido',
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.black87)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Lógica para publicar la nueva publicación
                Navigator.of(context).pop();
              },
              child:
                  const Text('Publicar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

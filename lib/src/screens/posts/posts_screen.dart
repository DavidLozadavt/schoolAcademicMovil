import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/posts/posts_controller.dart';

import 'package:photo_view/photo_view.dart';

class PostsScreen extends StatelessWidget {
  final PublicacionesController publicacionesController =
      Get.put(PublicacionesController());

  PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'VtBook',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.add_circle_outline, color: Colors.blueAccent),
            onPressed: () {
              _mostrarFormularioPublicacion(context);
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              // child: HistoriasWidget(), 
            ),
          ];
        },
        body: Obx(() {
          if (publicacionesController.publicaciones.isEmpty) {
            return Center(
              child: Text(
                'Aún no hay publicaciones',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => publicacionesController.fetchPublicaciones(),
            child: ListView.builder(
              itemCount: publicacionesController.publicaciones.length,
              itemBuilder: (context, index) {
                var publicacion = publicacionesController.publicaciones[index];
                return Card(
                  color: Colors.white,
                  elevation: 0.2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.5),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _mostrarPerfilInformativo(
                                  context,
                                  
                                  publicacion.user.persona.nombre1.toString(),
                                  publicacion.user.persona.apellido1.toString(),
                                  publicacion.user.persona.rutaFoto.toString(),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(publicacion
                                    .user.persona.rutaFoto
                                    .toString()),
                                radius: 25,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  publicacion.user.persona.nombre1.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${publicacion.fechaPublicacion.day}/${publicacion.fechaPublicacion.month}/${publicacion.fechaPublicacion.year}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 10, 10, 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: _buildDescription(publicacion.description),
                      ),
                      if (publicacion.urlImage.isNotEmpty) ...[
                        GestureDetector(
                          onTap: () => _mostrarImagenFullScreen(
                              context, publicacion.urlImage),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.network(
                              publicacion.urlImage,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('Error al cargar la imagen');
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }


 void _mostrarPerfilInformativo(BuildContext context, String nombre, String apellido, String rutaFoto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container( 
            width: MediaQuery.of(context).size.width * 0.8, 
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                ClipOval(
                  child: Image.network(
                    rutaFoto,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Error al cargar la imagen');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${nombre} ${apellido}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'DOCENTE',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}




  Widget _buildDescription(String description) {
    const int maxLength = 80;
    bool isExpanded = false;

    return StatefulBuilder(
      builder: (context, setState) {
        if (description.length <= maxLength) {
          return Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.grey[800]),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpanded
                    ? description
                    : description.substring(0, maxLength) + '...',
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Ver menos' : 'Ver más',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}

void _mostrarImagenFullScreen(BuildContext context, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
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
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
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
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.black87)),
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

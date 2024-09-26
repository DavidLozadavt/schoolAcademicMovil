import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/posts/full_screen_widget.dart';
import 'package:vtschool/src/screens/posts/posts_controller.dart';

class HistoriasWidget extends StatelessWidget {
  final PublicacionesController publicacionesController = Get.find();

  HistoriasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 150,
      child: Obx(() {
        if (publicacionesController.publicaciones.isEmpty) {
          return Center(
            child: Text(
              'Aún no hay historias',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: publicacionesController.publicaciones.length,
          itemBuilder: (context, index) {
            var publicacion = publicacionesController.publicaciones[index];
            return GestureDetector(
              onTap: () => _mostrarImagenFullScreen(context, publicacion.urlImage.toString()),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.5),
                      Colors.purple.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(publicacion.user!.persona!.rutaFoto.toString()),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      publicacion.user!.persona!.nombre1.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _mostrarImagenFullScreen(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
      ),
    );
  }
}

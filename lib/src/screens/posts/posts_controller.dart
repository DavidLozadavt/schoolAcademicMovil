import 'package:get/get.dart';
import 'package:vtschool/src/models/api_response_post.dart';

class PublicacionesController extends GetxController {
  var publicaciones = <Publicacion>[].obs;
  var indiceImagen = 0.obs;

  @override
  void onInit() {
    // Publicaciones de prueba con imágenes
    publicaciones.addAll([
      Publicacion(
        autor: 'Docente 1',
        contenido: 'Recordatorio: Entregar proyecto final antes del viernes.',
        fecha: DateTime.now().subtract(const Duration(days: 1)),
        imagenPerfil: 'assets/images/profile.png',
        imagenesPublicacion: [
          'assets/images/chica2.png',
          'assets/images/chica2.png',
          'assets/images/chica2.png',
        ],
      ),
      Publicacion(
        autor: 'Docente 2',
        contenido: 'Clase suspendida mañana debido a mantenimiento en el aula.',
        fecha: DateTime.now().subtract(const Duration(days: 2)),
        imagenPerfil: 'assets/images/profile.png',
        imagenesPublicacion: [],
      ),
      Publicacion(
        autor: 'Docente 3',
        contenido: 'Nueva actividad subida en la plataforma de educación.',
        fecha: DateTime.now().subtract(const Duration(hours: 3)),
        imagenPerfil: 'assets/images/profile.png',
        imagenesPublicacion: [],
      ),
    ]);
    super.onInit();
  }

  void agregarPublicacion(String autor, String contenido, String imagenPerfil, List<String> imagenesPublicacion) {
    // Crear una nueva publicación y agregarla a la lista
    publicaciones.add(Publicacion(
      autor: autor,
      contenido: contenido,
      fecha: DateTime.now(),
      imagenPerfil: imagenPerfil,
      imagenesPublicacion: imagenesPublicacion,
    ));
  }
}

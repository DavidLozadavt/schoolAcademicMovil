class Publicacion {
  final String autor;
  final DateTime fecha;
  final String contenido;
  final List<String> imagenesPublicacion; // Cambiado a una lista de imágenes
  final String imagenPerfil;

  Publicacion({
    required this.autor,
    required this.fecha,
    required this.contenido,
    required this.imagenesPublicacion, // Ahora soporta múltiples imágenes
    required this.imagenPerfil,
  });
}

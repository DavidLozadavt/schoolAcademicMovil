import 'dart:io';

import 'package:get/get.dart';
import 'package:vtschool/src/models/api_response_publications.dart';
import 'package:vtschool/src/providers/publication_provider.dart';

class PublicacionesController extends GetxController {
  var publicaciones = <Publicacion>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final PublicationProvider _publicationProvider = PublicationProvider();

  @override
  void onInit() {
    fetchPublicaciones();
    super.onInit();
  }

  Future<void> fetchPublicaciones() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      publicaciones.value = await _publicationProvider.getPublications();
    } catch (e) {
      errorMessage.value = 'Error al cargar publicaciones';
      Get.snackbar('Error', 'Algo salió mal en publicaciones');
    } finally {
      isLoading.value = false;
    }
  }


//metod for cretation of post
 Future<void> createPublicacion(File singleFile, List<File> multipleFiles, String description) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _publicationProvider.createPublication(singleFile, multipleFiles, description);
      await fetchPublicaciones(); 
      Get.snackbar('Éxito', 'Publicación creada exitosamente');
    } catch (e) {
      errorMessage.value = 'Error al crear la publicación';
      Get.snackbar('Error', 'Algo salió mal al crear la publicación');
    } finally {
      isLoading.value = false;
    }
  }


  // Método expuesto para refrescar directamente
  Future<void> refreshPublicaciones() async {
    await fetchPublicaciones();
  }
}

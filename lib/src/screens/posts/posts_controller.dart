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
      errorMessage.value = 'Error al obtener publicaciones: $e'; 
    } finally {
      isLoading.value = false; 
    }
  }

  
}

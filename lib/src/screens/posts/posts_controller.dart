import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vtschool/src/models/api_response_publications.dart';
import 'package:vtschool/src/providers/publication_provider.dart';
import 'package:image/image.dart' as img;


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




Future<File?> seleccionarImagen(BuildContext context) async {
  var status = await Permission.photos.status;
  if (!status.isGranted) {
    await Permission.photos.request();
  }

  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  
  if (image == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al seleccionar imagen')),
    );
    return null;
  }
  File resizedImage = await _redimensionarImagen(image);
  return resizedImage;
}


Future<List<File>?> seleccionarVariasImagenes(BuildContext context) async {
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
    final List<XFile> images = await picker.pickMultiImage();
    List<File> resizedImages = [];
    for (var image in images) {
      File resizedImage = await _redimensionarImagen(image);
      resizedImages.add(resizedImage);
    }
    return resizedImages;

    return null;
  }

 Future<File> _redimensionarImagen(XFile image) async {
    final imgFile = File(image.path);
    final imageBytes = await imgFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);
    img.Image resizedImage =
        img.copyResize(originalImage!, width: 800, height: 800);
    final resizedImageFile = File('${image.path}_resized.jpg');
    await resizedImageFile
        .writeAsBytes(img.encodeJpg(resizedImage, quality: 90));
    return resizedImageFile;
  }




  
}

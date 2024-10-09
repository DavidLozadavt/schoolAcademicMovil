import 'dart:io';

import 'package:dio/dio.dart';
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
    } on DioError catch (dioError) {
      errorMessage.value = 'Error de conexión: ${dioError.message}';
      Get.snackbar('Error de red', 'No se pudo conectar al servidor');
    } catch (e) {
      errorMessage.value = 'Error al cargar publicaciones: $e';
      Get.snackbar('Error', 'Algo salió mal: $e');
      //print('Error: $e');
      //print('Stack trace: $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

//metod for cretation of post
  Future<void> createPublicacion(
      File singleFile, List<File> multipleFiles, String description) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _publicationProvider.createPublication(
          singleFile, multipleFiles, description);
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
    File resizedImage = await _reducirCalidadImagen(image);
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

    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al seleccionar imágenes')),
      );
      return null;
    }

    // Muestra el diálogo de progreso
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Cargando imágenes...'),
              ],
            ),
          ),
        );
      },
    );

    List<File> resizedImages = [];
    for (var image in images) {
      File resizedImage = await _reducirCalidadImagen(image);
      resizedImages.add(resizedImage);
    }

    // Cierra el diálogo de progreso
   // Navigator.of(context).pop();
    Get.back();

    return resizedImages;
  }

  // Future<File> _reducirCalidadImagen(XFile image) async {
  //   final imgFile = File(image.path);
  //   final imageBytes = await imgFile.readAsBytes();
  //   img.Image? originalImage = img.decodeImage(imageBytes);
  //   img.Image resizedImage =
  //       img.copyResize(originalImage!, width: 1000, height: 1000);
  //   final resizedImageFile = File('${image.path}_resized.jpg');
  //   await resizedImageFile
  //       .writeAsBytes(img.encodeJpg(resizedImage, quality: 90));
  //   return resizedImageFile;
  // }

  Future<File> _reducirCalidadImagen(XFile image) async {
    final imgFile = File(image.path);
    final imageBytes = await imgFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);
    final reducedQualityImageFile = File('${image.path}_reduced_quality.jpg');
    await reducedQualityImageFile
        .writeAsBytes(img.encodeJpg(originalImage!, quality: 70));

    return reducedQualityImageFile;
  }
}

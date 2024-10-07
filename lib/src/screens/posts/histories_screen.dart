import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/posts/posts_controller.dart';

import '../../models/api_response_publications.dart';

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
              onTap: () => _mostrarImagenFullScreen(context, publicacion),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6605),
                      Color(0xFFFFDC4A),
                      
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
                        backgroundImage: NetworkImage(
                            publicacion.user!.persona!.rutaFoto.toString()),
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

  void _mostrarImagenFullScreen(BuildContext context, Publicacion publicacion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(publicacion: publicacion),
      ),
    );
    
  }
  
}

class FullScreenImagePage extends StatefulWidget {
  final Publicacion publicacion;

  FullScreenImagePage({required this.publicacion});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  List<double> _progresses = [];

  @override
  void initState() {
    super.initState();
    _progresses = List<double>.filled(widget.publicacion.imagenes!.length, 0.0);

    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentIndex < widget.publicacion.imagenes!.length - 1) {
        _currentIndex++;
      } else {
        Navigator.pop(context);
        return;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      _resetProgress(_currentIndex);
    });

    _startProgress();
  }

  void _resetProgress(int index) {
    setState(() {
      _progresses[index] = 0.0;
    });
  }

  void _startProgress() {
    Timer.periodic(Duration(milliseconds: 35), (timer) {
      setState(() {
        _progresses[_currentIndex] += 0.01;
      });

      if (_progresses[_currentIndex] >= 1.0) {
        timer.cancel();
        _startProgress();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _navegarAPublicacion() {
    Get.toNamed('/posts', arguments: widget.publicacion.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _navegarAPublicacion, // Agrega la acción al tocar la imagen
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.publicacion.imagenes!.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.publicacion.imagenes![index].urlImage,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              children: List.generate(
                widget.publicacion.imagenes!.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: LinearProgressIndicator(
                      value: _progresses[index],
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFF6605),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

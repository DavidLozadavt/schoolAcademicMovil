import 'package:flutter/material.dart';
import 'package:vtschool/src/models/api_response_publications.dart';
import 'package:vtschool/src/screens/posts/full_screen_widget.dart';

class PageViewWithIndicators extends StatefulWidget {
  final Publicacion publicacion;

  const PageViewWithIndicators({super.key, required this.publicacion});

  @override
  _PageViewWithIndicatorsState createState() => _PageViewWithIndicatorsState();
}

class _PageViewWithIndicatorsState extends State<PageViewWithIndicators> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _mostrarImagenFullScreen(context, _currentIndex),
          child: SizedBox(
            height: 450,
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                if (widget.publicacion.urlImage!.isNotEmpty)
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      widget.publicacion.urlImage.toString(),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Error al cargar la imagen');
                      },
                    ),
                  ),
                ...widget.publicacion.imagenes!.map((imagen) {
                  return ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      imagen.urlImage.toString(),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Error al cargar la imagen');
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildIndicators(),
      ],
    );
  }

  void _mostrarImagenFullScreen(BuildContext context, int index) {
    String imageUrl;

    if (index == 0 && widget.publicacion.urlImage!.isNotEmpty) {
      imageUrl = widget.publicacion.urlImage!; // URL de la primera imagen
    } else {
      imageUrl = widget.publicacion.imagenes![index - 1]
          .urlImage!; // URL de la imagen correspondiente
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.publicacion.urlImage!.isNotEmpty
            ? 1 + widget.publicacion.imagenes!.length
            : widget.publicacion.imagenes!.length,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
              color: _currentIndex == index ? const Color(0xFFFF6605) : Colors.grey,
              borderRadius: BorderRadius.circular(4.0),
            ),
          );
        },
      ),
    );
  }
}

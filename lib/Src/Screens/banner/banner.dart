import 'package:flutter/material.dart';
import 'package:popup_banner/popup_banner.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  List<String> images = [
    "assets/images/enviar.png",
    "assets/images/enviar.png",
  ];

  List<String> imagesLocal = [
    "assets/images/enviar.png",
    "assets/images/enviar.png",
  ];

  void showDefaultPopup() {
    PopupBanner(
      context: context,
      images: images,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showHideDotsPopup() {
    PopupBanner(
      context: context,
      images: images,
      useDots: false,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showCustomizeDots() {
    PopupBanner(
      context: context,
      images: images,
      dotsAlignment: Alignment.bottomCenter,
      dotsColorActive: Colors.blue,
      dotsColorInactive: Colors.grey.withOpacity(0.5),
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showNonactiveSlideCustomClose() {
    PopupBanner(
      context: context,
      images: images,
      autoSlide: false,
      customCloseButton: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: const Text(
          "Close",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showFromLocal() {
    PopupBanner(
      context: context,
      images: imagesLocal,
      fromNetwork: false,
      onClick: (index) {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buttonWidget(
              title: "Default Popup",
              onClick: () => showDefaultPopup(),
            ),
            _buttonWidget(
              title: "Hide Dots Popup",
              onClick: () => showHideDotsPopup(),
            ),
            _buttonWidget(
              title: "Customize Dots Popup",
              onClick: () => showCustomizeDots(),
            ),
            _buttonWidget(
              title: "Disable Auto Slide & Custom Close Popup",
              onClick: () => showNonactiveSlideCustomClose(),
            ),
            _buttonWidget(
              title: "Local Asset Popup",
              onClick: () => showFromLocal(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonWidget({
    required String title,
    required VoidCallback onClick,
  }) {
    return ElevatedButton(
      onPressed: () => onClick(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class ItemNavigationButton extends StatelessWidget {
  const ItemNavigationButton(
      {super.key,
      required this.fileIcon,
      required this.title,
      this.isActive = false});
  final String fileIcon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(AssetImage(fileIcon),
            size: isActive ? 40 : 30,
            color: isActive ? listColor[13] : listColor[12].withOpacity(0.7)),
        Text(title,
            style: TextStyle(
                color: isActive ? listColor[13] : listColor[12].withOpacity(0.5),
                fontSize: isActive ? 13 : 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}

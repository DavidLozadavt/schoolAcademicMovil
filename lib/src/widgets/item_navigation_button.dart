import 'package:flutter/material.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';

class ItemNavigationButton extends StatelessWidget {
  const ItemNavigationButton({
    Key? key,
    required this.fileIcon,
    required this.title,
    this.isActive = false,
    this.messageCount = 0,
  }) : super(key: key);

  final String fileIcon;
  final String title;
  final bool isActive;
  final int messageCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ImageIcon(
              AssetImage(fileIcon),
              size: 30,
              color: isActive ? listColor[13] : listColor[12].withOpacity(0.7),
            ),
            if (messageCount > 0)
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$messageCount',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
            color: isActive ? listColor[13] : listColor[12].withOpacity(0.5),
            fontSize: isActive ? 13 : 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

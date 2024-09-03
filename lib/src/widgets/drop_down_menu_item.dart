import 'package:flutter/material.dart';

DropdownMenuItem<int> customDropdownMenuItem({
  required String text,
  required bool enabled,
  required int value,
  required Function onTap,
  IconData? icon,

  Color color = const Color(0xFFE8E8E8),
  Color colorText = Colors.black54,
  Color colorBorder = Colors.black26,
}) {
  return DropdownMenuItem<int>(
    onTap: () => onTap(),
    alignment: Alignment.center,
    enabled: enabled,
    value: value,
    child: Container(
      alignment: Alignment.center,
      decoration: enabled
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: colorBorder,
              ),
              color: color,
            )
          : null,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              size: 18,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: enabled ? colorText : Colors.grey[300],
              fontSize: 12,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    ),
  );
}

// form_field_widget.dart
import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final bool isReadOnly;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final TextAlignVertical textAlignVertical;

  const FormFieldWidget({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.validator,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.textAlignVertical = TextAlignVertical.top,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          readOnly: isReadOnly,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: minLines,
          textAlignVertical: textAlignVertical,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}

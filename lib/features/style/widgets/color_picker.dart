import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class AppColorPicker extends StatefulWidget {
  const AppColorPicker({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final void Function(Color) onColorChanged;

  @override
  State<AppColorPicker> createState() => _AppColorPickerState();
}

class _AppColorPickerState extends State<AppColorPicker> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 400),
      child: Column(
        children: [
          ColorPicker(
            color: widget.color,
            onColorChanged: widget.onColorChanged,
            wheelDiameter: 250,
            wheelWidth: 25,
            pickersEnabled: const {
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.wheel: true,
            },
          ),
        ],
      ),
    );
  }
}

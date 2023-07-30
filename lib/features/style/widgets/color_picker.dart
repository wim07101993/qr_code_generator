import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
            pickerColor: widget.color,
            onColorChanged: widget.onColorChanged,
            pickerAreaHeightPercent: 0.7,
            enableAlpha: false, // hexInputController will respect it too.
            displayThumbColor: true,
            labelTypes: const [],
            pickerAreaBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
            hexInputController: textController, // <- here
            portraitOnly: true,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: textController,
              autofocus: true,
              maxLength: 9,
              inputFormatters: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

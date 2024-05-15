import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class ColorPickerDialogButton extends StatelessWidget {
  const ColorPickerDialogButton({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final foregroundColor = isDarkColor(color) ? Colors.white : Colors.black;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        foregroundColor: WidgetStatePropertyAll(foregroundColor),
      ),
      onPressed: () => showDialog<Color?>(
        context: context,
        builder: (context) => ColorPickerDialog(
          initialColor: color,
          onColorChanged: onColorChanged,
        ),
      ),
      child: Text(s.changeColor),
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.onColorChanged,
  });

  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final textController = TextEditingController();

  late Color selectedColor = widget.initialColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              color: selectedColor,
              onColorChanged: (color) {
                setState(() => selectedColor = color);
                widget.onColorChanged(color);
              },
              pickersEnabled: const {
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.wheel: true,
              },
            ),
          ],
        ),
      ),
    );
  }
}

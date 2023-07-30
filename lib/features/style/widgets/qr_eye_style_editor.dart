import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/features/style/widgets/color_picker_dialog.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class QrEyeStyleEditor extends StatelessWidget {
  const QrEyeStyleEditor({
    super.key,
    required this.style,
    required this.onStyleChanged,
  });

  final QrEyeStyle style;
  final ValueChanged<QrEyeStyle> onStyleChanged;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(s.qrEyeStyle, style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        _shape(s),
        const SizedBox(height: 16),
        Text(s.color, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.topLeft,
          child: ColorPickerDialogButton(
            color: style.color ?? Colors.black,
            onColorChanged: (color) => onStyleChanged(
              QrEyeStyle(
                color: color,
                eyeShape: style.eyeShape,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shape(AppLocalizations s) {
    return DropdownButtonFormField<QrEyeShape>(
      value: style.eyeShape,
      items: QrEyeShape.values
          .map(
            (shape) => DropdownMenuItem(
              value: shape,
              child: Text(shape.translate(s)),
            ),
          )
          .toList(),
      decoration: InputDecoration(label: Text(s.shape)),
      onChanged: (shape) => onStyleChanged(
        QrEyeStyle(
          color: style.color,
          eyeShape: shape,
        ),
      ),
    );
  }
}

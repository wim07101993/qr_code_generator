import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/features/style/widgets/color_picker_dialog.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class QrDataModuleStyleEditor extends StatelessWidget {
  const QrDataModuleStyleEditor({
    super.key,
    required this.style,
    required this.onStyleChanged,
  });

  final QrDataModuleStyle style;
  final ValueChanged<QrDataModuleStyle> onStyleChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(s.qrDataModuleStyle, style: theme.textTheme.titleLarge),
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
              QrDataModuleStyle(
                color: color,
                dataModuleShape: style.dataModuleShape,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shape(AppLocalizations s) {
    return DropdownButtonFormField<QrDataModuleShape>(
      value: style.dataModuleShape,
      decoration: InputDecoration(label: Text(s.shape)),
      items: QrDataModuleShape.values
          .map(
            (shape) => DropdownMenuItem(
              value: shape,
              child: Text(shape.translate(s)),
            ),
          )
          .toList(),
      onChanged: (shape) => onStyleChanged(
        QrDataModuleStyle(
          color: style.color,
          dataModuleShape: shape,
        ),
      ),
    );
  }
}

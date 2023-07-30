import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/widgets/color_picker_dialog.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class BackgroundStyleEditor extends StatelessWidget {
  const BackgroundStyleEditor({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(s.background, style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        Text(s.color, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.topLeft,
          child: ColorPickerDialogButton(
            color: color,
            onColorChanged: onColorChanged,
          ),
        )
      ],
    );
  }
}

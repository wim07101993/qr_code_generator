import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_code_generator/l10n/localization.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/style/notifiers/style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StyleScreen extends StatelessWidget {
  const StyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, notifier, _) => _settings(context, notifier),
    );
  }

  Widget _settings(BuildContext context, StyleSettings settings) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final notifier = getIt<StyleSettingsNotifier>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(s.qrCodeStyleScreenTitle, style: theme.textTheme.headline4),
        const SizedBox(height: 24),
        Text(s.qrDataModuleStyle, style: theme.textTheme.headline5),
        const SizedBox(height: 16),
        Text(s.shape, style: theme.textTheme.headline6),
        const SizedBox(height: 16),
        DropdownButtonFormField<QrDataModuleShape>(
          value: settings.dataModuleStyle.dataModuleShape,
          items: QrDataModuleShape.values
              .map(
                (shape) => DropdownMenuItem(
                  value: shape,
                  child: Text(shape.translate(s)),
                ),
              )
              .toList(),
          onChanged: (shape) {
            notifier.value = settings.copyWithDataModuleStyle(
              QrDataModuleStyle(
                color: settings.dataModuleStyle.color,
                dataModuleShape: shape,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(s.color, style: theme.textTheme.headline6),
        const SizedBox(height: 16),
        ColorPicker(
          pickerColor: settings.dataModuleStyle.color ?? Colors.black,
          displayThumbColor: true,
          enableAlpha: false,
          paletteType: PaletteType.hslWithHue,
          onColorChanged: (color) {
            notifier.value = settings.copyWithDataModuleStyle(
              QrDataModuleStyle(
                color: color,
                dataModuleShape: settings.dataModuleStyle.dataModuleShape,
              ),
            );
          },
        ),
        const Divider(),
        const SizedBox(height: 24),
        Text(s.qrEyeStyle, style: theme.textTheme.headline5),
        const SizedBox(height: 16),
        Text(s.shape, style: theme.textTheme.headline6),
        const SizedBox(height: 16),
        DropdownButtonFormField<QrEyeShape>(
          value: settings.eyeStyle.eyeShape,
          items: QrEyeShape.values
              .map(
                (shape) => DropdownMenuItem(
                  value: shape,
                  child: Text(shape.translate(s)),
                ),
              )
              .toList(),
          onChanged: (shape) => notifier.value = settings.copyWithEyeStyle(
            QrEyeStyle(
              color: settings.eyeStyle.color,
              eyeShape: shape,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(s.color, style: theme.textTheme.headline6),
        const SizedBox(height: 16),
        ColorPicker(
          pickerColor: settings.eyeStyle.color ?? Colors.black,
          displayThumbColor: true,
          enableAlpha: false,
          paletteType: PaletteType.hslWithHue,
          onColorChanged: (color) => notifier.value = settings.copyWithEyeStyle(
            QrEyeStyle(
              color: color,
              eyeShape: settings.eyeStyle.eyeShape,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        Text(s.backgroundColor, style: theme.textTheme.headline5),
        const SizedBox(height: 16),
        ColorPicker(
          pickerColor: settings.backgroundColor,
          displayThumbColor: true,
          enableAlpha: false,
          paletteType: PaletteType.hslWithHue,
          onColorChanged: (color) {
            notifier.value = settings.copyWithBackgroundColor(color);
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        Text(s.image, style: theme.textTheme.headline5),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                settings.embeddedImageFilePath ?? s.none,
                overflow: TextOverflow.clip,
              ),
            ),
            if (settings.embeddedImageFilePath != null)
              TextButton(
                onPressed: () => notifier.value =
                    settings.copyWithEmbeddedImageFilePath(null),
                child: Text(s.removeImageButtonLabel),
              ),
            TextButton(
              onPressed: () => _selectFile(notifier),
              child: Text(s.selectImageFileButtonLabel),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectFile(StyleSettingsNotifier notifier) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      notifier.value = notifier.value
          .copyWithEmbeddedImageFilePath(result.files.single.path);
    }
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
    final theme = Theme.of(context);
    final notifier = getIt<StyleSettingsNotifier>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('QR-code style', style: theme.textTheme.headline4),
        const Text('Gapless'),
        Row(
          children: [
            Checkbox(
              value: !settings.gapless,
              onChanged: (value) => notifier.value = settings.copyWithGapless(
                gapless: !(value ?? false),
              ),
            ),
            const Text('Enable gaps between the modules'),
          ],
        ),
        const Divider(),
        const Text('Background color'),
        ColorPicker(
          pickerColor: settings.backgroundColor,
          displayThumbColor: true,
          enableAlpha: false,
          paletteType: PaletteType.hslWithHue,
          onColorChanged: (color) {
            notifier.value = settings.copyWithBackgroundColor(color);
          },
        ),
        const Divider(),
        Text('Image', style: theme.textTheme.headline5),
        Row(
          children: [
            Text(settings.embeddedImageFilePath ?? 'none'),
            const Spacer(),
            if (settings.embeddedImageFilePath != null)
              TextButton(
                onPressed: () => notifier.value =
                    settings.copyWithEmbeddedImageFilePath(null),
                child: const Text('Remove'),
              ),
            TextButton(
              onPressed: () => _selectFile(notifier),
              child: const Text('Select file'),
            ),
          ],
        ),
        const Divider(),
        Text('Qr data module style', style: theme.textTheme.headline5),
        const Text('Shape'),
        DropdownButtonFormField<QrDataModuleShape>(
          value: settings.dataModuleStyle.dataModuleShape,
          items: QrDataModuleShape.values
              .map(
                (shape) => DropdownMenuItem(
                  value: shape,
                  child: Text(shape.name),
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
        const Text('Color'),
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
        Text('Qr eye style', style: theme.textTheme.headline5),
        const Text('Shape'),
        DropdownButtonFormField<QrEyeShape>(
          value: settings.eyeStyle.eyeShape,
          items: QrEyeShape.values
              .map(
                (shape) => DropdownMenuItem(
                  value: shape,
                  child: Text(shape.name),
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
        const Text('Color'),
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

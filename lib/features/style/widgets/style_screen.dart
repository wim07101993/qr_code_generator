import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

@RoutePage()
class StyleScreen extends StatelessWidget {
  const StyleScreen({super.key});

  Future<void> _selectFile(StyleSettingsNotifier notifier) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      notifier.value = notifier.value
          .copyWithEmbeddedImageFilePath(result.files.single.path);
    }
  }

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
        Text(s.qrCodeStyleScreenTitle, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 24),
        ..._dataModuleStyle(s, theme, notifier, settings),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        ..._eyeStyle(s, theme, notifier, settings),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        Text(s.image, style: theme.textTheme.titleLarge),
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
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        ..._background(s, theme, notifier, settings),
      ],
    );
  }

  List<Widget> _dataModuleStyle(
    AppLocalizations s,
    ThemeData theme,
    StyleSettingsNotifier notifier,
    StyleSettings settings,
  ) {
    return [
      Text(s.qrDataModuleStyle, style: theme.textTheme.titleLarge),
      const SizedBox(height: 16),
      DropdownButtonFormField<QrDataModuleShape>(
        value: settings.dataModuleStyle.dataModuleShape,
        decoration: InputDecoration(label: Text(s.shape)),
        items: QrDataModuleShape.values
            .map(
              (shape) => DropdownMenuItem(
                value: shape,
                child: Text(shape.translate(s)),
              ),
            )
            .toList(),
        onChanged: (shape) => notifier.value = settings.copyWithDataModuleStyle(
          QrDataModuleStyle(
            color: settings.dataModuleStyle.color,
            dataModuleShape: shape,
          ),
        ),
      ),
      const SizedBox(height: 16),
      Text(s.color, style: theme.textTheme.titleSmall),
      const SizedBox(height: 12),
      _colorPicker(
        settings.dataModuleStyle.color ?? Colors.black,
        (color) => notifier.value = settings.copyWithDataModuleStyle(
          QrDataModuleStyle(
            color: color,
            dataModuleShape: settings.dataModuleStyle.dataModuleShape,
          ),
        ),
      ),
    ];
  }

  List<Widget> _eyeStyle(
    AppLocalizations s,
    ThemeData theme,
    StyleSettingsNotifier notifier,
    StyleSettings settings,
  ) {
    return [
      Text(s.qrEyeStyle, style: theme.textTheme.titleLarge),
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
        decoration: InputDecoration(label: Text(s.shape)),
        onChanged: (shape) => notifier.value = settings.copyWithEyeStyle(
          QrEyeStyle(
            color: settings.eyeStyle.color,
            eyeShape: shape,
          ),
        ),
      ),
      const SizedBox(height: 16),
      Text(s.color, style: theme.textTheme.titleSmall),
      const SizedBox(height: 12),
      _colorPicker(
        settings.eyeStyle.color ?? Colors.black,
        (color) => notifier.value = settings.copyWithEyeStyle(
          QrEyeStyle(
            color: color,
            eyeShape: settings.eyeStyle.eyeShape,
          ),
        ),
      ),
    ];
  }

  List<Widget> _background(
    AppLocalizations s,
    ThemeData theme,
    StyleSettingsNotifier notifier,
    StyleSettings settings,
  ) {
    return [
      Text(s.background, style: theme.textTheme.titleLarge),
      const SizedBox(height: 16),
      Text(s.color, style: theme.textTheme.titleSmall),
      const SizedBox(height: 12),
      ColorPicker(
        pickerColor: settings.backgroundColor,
        displayThumbColor: true,
        enableAlpha: false,
        paletteType: PaletteType.hslWithHue,
        onColorChanged: (color) {
          notifier.value = settings.copyWithBackgroundColor(color);
        },
      ),
    ];
  }

  Widget _colorPicker(Color color, void Function(Color) onColorChanged) {
    return ColorPicker(
      pickerColor: color,
      displayThumbColor: true,
      enableAlpha: false,
      paletteType: PaletteType.hslWithHue,
      onColorChanged: onColorChanged,
    );
  }
}

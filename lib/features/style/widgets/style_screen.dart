import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/features/style/widgets/background_style_editor.dart';
import 'package:qr_code_generator/features/style/widgets/image_editor.dart';
import 'package:qr_code_generator/features/style/widgets/qr_data_module_style_editor.dart';
import 'package:qr_code_generator/features/style/widgets/qr_eye_style_editor.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/widgets/styled_qr_code.dart';

@RoutePage()
class StyleScreen extends StatelessWidget {
  const StyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => ValueListenableBuilder<StyleSettings>(
        valueListenable: getIt<StyleSettingsNotifier>(),
        builder: (context, notifier, _) => Column(
          children: [
            Text(
              s.qrCodeStyleScreenTitle,
              style: theme.textTheme.headlineMedium,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight / 4),
              child: const StyledQrCode(
                data: 'This is a test image for styling',
              ),
            ),
            Expanded(child: _settings(s, theme, notifier)),
          ],
        ),
      ),
    );
  }

  Widget _settings(
    AppLocalizations s,
    ThemeData theme,
    StyleSettings settings,
  ) {
    final notifier = getIt<StyleSettingsNotifier>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 24),
        QrDataModuleStyleEditor(
          style: settings.dataModuleStyle,
          onStyleChanged: (style) {
            notifier.value = notifier.value.copyWithDataModuleStyle(style);
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        QrEyeStyleEditor(
          style: notifier.value.eyeStyle,
          onStyleChanged: (style) {
            notifier.value = notifier.value.copyWithEyeStyle(style);
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        Text(s.image, style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        ImageEditor(
          image: notifier.value.embeddedImage,
          onImageChanged: (value) {
            notifier.value = notifier.value.copyWithEmbeddedImage(value);
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
        BackgroundStyleEditor(
          color: settings.backgroundColor,
          onColorChanged: (color) {
            notifier.value = settings.copyWithBackgroundColor(color);
          },
        ),
      ],
    );
  }
}

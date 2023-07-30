import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/main.dart';

class StyledQrCode extends StatelessWidget {
  const StyledQrCode({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, style, _) => QrImageView(
        data: data,
        dataModuleStyle: style.dataModuleStyle,
        embeddedImage: style.embeddedImage,
        embeddedImageStyle: style.embeddedImageStyle,
        eyeStyle: style.eyeStyle,
        gapless: style.gapless,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/style/notifiers/style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TextQrCodeScreen extends StatefulWidget {
  const TextQrCodeScreen({super.key});

  @override
  State<TextQrCodeScreen> createState() => _TextQrCodeScreenState();
}

class _TextQrCodeScreenState extends State<TextQrCodeScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, styleSettings, _) => Column(
        children: [
          _text(context),
          const SizedBox(height: 8),
          Expanded(child: _qrCode(styleSettings)),
        ],
      ),
    );
  }

  Widget _text(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }

  Widget _qrCode(StyleSettings settings) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, _) => QrImage(
        data: controller.text,
        dataModuleStyle: settings.dataModuleStyle,
        embeddedImage: settings.embeddedImage,
        embeddedImageStyle: settings.embeddedImageStyle,
        eyeStyle: settings.eyeStyle,
        gapless: settings.gapless,
      ),
    );
  }
}

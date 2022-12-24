import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/style/notifiers/style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({
    super.key,
    required this.inputBuilder,
    required this.qrData,
  });

  final WidgetBuilder inputBuilder;
  final ValueListenable<String> qrData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final qrSize = min(constraints.maxWidth, constraints.maxHeight);
        return ListView(
          children: [
            Center(
              child: ValueListenableBuilder<StyleSettings>(
                valueListenable: getIt<StyleSettingsNotifier>(),
                builder: (context, style, _) => ValueListenableBuilder<String>(
                  valueListenable: qrData,
                  builder: (context, qrData, _) => QrImage(
                    size: qrSize,
                    data: qrData,
                    dataModuleStyle: style.dataModuleStyle,
                    embeddedImage: style.embeddedImage,
                    embeddedImageStyle: style.embeddedImageStyle,
                    eyeStyle: style.eyeStyle,
                    gapless: style.gapless,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            inputBuilder(context),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

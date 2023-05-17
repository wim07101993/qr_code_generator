import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/main.dart';

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
        final qrCode = ValueListenableBuilder<StyleSettings>(
          valueListenable: getIt<StyleSettingsNotifier>(),
          builder: (context, style, _) => ValueListenableBuilder<String>(
            valueListenable: qrData,
            builder: (context, qrData, _) => QrImageView(
              size: min(constraints.maxWidth, constraints.maxHeight),
              data: qrData,
              dataModuleStyle: style.dataModuleStyle,
              embeddedImage: style.embeddedImage,
              embeddedImageStyle: style.embeddedImageStyle,
              eyeStyle: style.eyeStyle,
              gapless: style.gapless,
            ),
          ),
        );

        const double inputWidth = 250;
        final input = Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: inputWidth,
              maxWidth: inputWidth,
            ),
            child: inputBuilder(context),
          ),
        );

        if ((constraints.maxWidth - inputWidth) > constraints.maxHeight) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: input),
              qrCode,
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(children: [qrCode, input]),
          );
        }
      },
    );
  }
}

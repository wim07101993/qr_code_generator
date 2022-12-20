import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeStyleSettingsNotifier extends ValueNotifier<QrCodeStyleSettings> {
  QrCodeStyleSettingsNotifier() : super(QrCodeStyleSettings());
}

class QrCodeStyleSettings {
  static const defaultBackgroundColor = Colors.white;
  static const defaultDataModuleStyle = QrDataModuleStyle(
    dataModuleShape: QrDataModuleShape.square,
    color: Colors.black,
  );
  static const defaultEyeStyle = QrEyeStyle(
    eyeShape: QrEyeShape.square,
    color: Colors.black,
  );
  static const defaultGapless = true;

  QrCodeStyleSettings({
    this.backgroundColor = defaultBackgroundColor,
    this.dataModuleStyle = defaultDataModuleStyle,
    this.embeddedImageFilePath,
    this.embeddedImageStyle,
    this.eyeStyle = defaultEyeStyle,
    this.gapless = defaultGapless,
  });

  final Color backgroundColor;
  final QrDataModuleStyle dataModuleStyle;
  final String? embeddedImageFilePath;
  final QrEmbeddedImageStyle? embeddedImageStyle;
  final QrEyeStyle eyeStyle;
  final bool gapless;

  ImageProvider? get embeddedImage {
    final path = embeddedImageFilePath;
    return path == null ? null : FileImage(File(path));
  }

  QrCodeStyleSettings copyWithBackgroundColor(Color backgroundColor) {
    return QrCodeStyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  QrCodeStyleSettings copyWithDataModuleStyle(
    QrDataModuleStyle dataModuleStyle,
  ) {
    return QrCodeStyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  QrCodeStyleSettings copyWithEmbeddedImageFilePath(
    String? embeddedImageFilePath,
  ) {
    return QrCodeStyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  QrCodeStyleSettings copyWithEmbeddedImageStyle(
    QrEmbeddedImageStyle? embeddedImageStyle,
  ) {
    return QrCodeStyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  QrCodeStyleSettings copyWithEyeStyle(QrEyeStyle eyeStyle) {
    return QrCodeStyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  QrCodeStyleSettings copyWithGapless({required bool gapless}) {
    return QrCodeStyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }
}

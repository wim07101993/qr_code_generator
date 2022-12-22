part of 'shared_preferences_extensions.dart';

extension _JsonExtensions on Map<String, dynamic> {
  QrCodeStyleSettings toQrCodeStyleSettings() {
    return QrCodeStyleSettings(
      backgroundColor: getColor('backgroundColor') ??
          QrCodeStyleSettings.defaultBackgroundColor,
      dataModuleStyle: getObject('dataModuleStyle')?.toQrDataModuleStyle() ??
          QrCodeStyleSettings.defaultDataModuleStyle,
      embeddedImageFilePath: getString('embeddedImageFilePath'),
      embeddedImageStyle:
          getObject('embeddedImageStyle')?.toQrEmbeddedImageStyle(),
      eyeStyle: getObject('eyeStyle')?.toQrEyeStyle() ??
          QrCodeStyleSettings.defaultEyeStyle,
      gapless: getBool('gapless') ?? QrCodeStyleSettings.defaultGapless,
    );
  }

  Color? getColor(String key) => getInt(key)?.toColor();

  QrDataModuleStyle toQrDataModuleStyle() {
    return QrDataModuleStyle(
      color: getColor('color'),
      dataModuleShape: getString('dataModuleShape')?.toQrDataModuleShape(),
    );
  }

  QrEmbeddedImageStyle toQrEmbeddedImageStyle() {
    return QrEmbeddedImageStyle(
      color: getColor('color'),
    );
  }

  QrEyeStyle toQrEyeStyle() {
    return QrEyeStyle(
      color: getColor('color'),
      eyeShape: getString('eyeShape')?.toQrEyeShape(),
    );
  }
}

extension _IntExtensions on int {
  Color toColor() => Color(this);
}

extension _StringExtensions on String {
  QrDataModuleShape toQrDataModuleShape() {
    return QrDataModuleShape.values.firstWhere(
      (shape) => shape.name == this,
      orElse: () => QrDataModuleShape.square,
    );
  }

  QrEyeShape toQrEyeShape() {
    return QrEyeShape.values.firstWhere(
      (shape) => shape.name == this,
      orElse: () => QrEyeShape.square,
    );
  }
}

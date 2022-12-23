part of 'shared_preferences_extensions.dart';

extension _JsonExtensions on Map<String, dynamic> {
  StyleSettings toStyleSettings() {
    return StyleSettings(
      backgroundColor:
          getColor('backgroundColor') ?? StyleSettings.defaultBackgroundColor,
      dataModuleStyle: getObject('dataModuleStyle')?.toQrDataModuleStyle() ??
          StyleSettings.defaultDataModuleStyle,
      embeddedImageFilePath: getString('embeddedImageFilePath'),
      embeddedImageStyle:
          getObject('embeddedImageStyle')?.toQrEmbeddedImageStyle(),
      eyeStyle: getObject('eyeStyle')?.toQrEyeStyle() ??
          StyleSettings.defaultEyeStyle,
      gapless: getBool('gapless') ?? StyleSettings.defaultGapless,
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

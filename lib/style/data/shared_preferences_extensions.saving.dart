part of 'shared_preferences_extensions.dart';

extension _StyleSettingsExtensions on StyleSettings {
  Map<String, dynamic> toJson() {
    return {
      'backgroundColor': backgroundColor.value,
      'dataModuleStyle': dataModuleStyle.toJsonMap(),
      'embeddedImageFilePath': embeddedImageFilePath,
      'embeddedImageStyle': embeddedImageStyle?.toJsonMap(),
      'eyeStyle': eyeStyle.toJson(),
      'gapless': gapless,
    };
  }
}

extension _QrDataModuleStyleExtensions on QrDataModuleStyle {
  Map<String, dynamic> toJsonMap() {
    return {
      'dataModuleShape': dataModuleShape?.name,
      'color': color?.value,
    };
  }
}

extension _QrEmbeddedImageStyleExtensions on QrEmbeddedImageStyle {
  Map<String, dynamic> toJsonMap() {
    return {
      'size': size?.toJsonMap(),
      'color': color?.value,
    };
  }
}

extension _SizeExtensions on Size {
  Map<String, dynamic> toJsonMap() {
    return {
      'height': height,
      'width': width,
    };
  }
}

extension _QrEyeStyleExtensions on QrEyeStyle {
  Map<String, dynamic> toJson() {
    return {
      'eyeShape': eyeShape?.name,
      'color': color?.value,
    };
  }
}

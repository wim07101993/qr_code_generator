import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/data/json_extensions.dart';
import 'package:qr_code_generator/qr_code_style/notifiers/qr_code_style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _qrCodeStyleSettingsKey = 'qrCodeStyleSettings';

extension QrCodeStyleSettingsExtensions on QrCodeStyleSettingsNotifier {
  Future<void> loadFromSharedPreferences(
    SharedPreferences sharedPreferences,
  ) async {
    try {
      final jsonData =
          sharedPreferences.get(_qrCodeStyleSettingsKey) as String?;
      if (jsonData == null) {
        return;
      }
      final map = jsonDecode(jsonData) as Map<String, dynamic>;
      loadFromJson(map);
    } catch (e, stackTrace) {
      log(
        'Error while reading previously stored qr-code style settings',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void loadFromJson(Map<String, dynamic> json) {
    value = QrCodeStyleSettings(
      backgroundColor: json.getColor('backgroundColor') ??
          QrCodeStyleSettings.defaultBackgroundColor,
      dataModuleStyle:
          json.getObject('dataModuleStyle')?.toQrDataModuleStyle() ??
              QrCodeStyleSettings.defaultDataModuleStyle,
      embeddedImageFilePath: json.getString('embeddedImageFilePath'),
      embeddedImageStyle:
          json.getObject('embeddedImageStyle')?.toQrEmbeddedImageStyle(),
      eyeStyle: json.getObject('eyeStyle')?.toQrEyeStyle() ??
          QrCodeStyleSettings.defaultEyeStyle,
      gapless: json.getBool('gapless') ?? QrCodeStyleSettings.defaultGapless,
    );
  }

  Future<void> saveToSharedPreferences(
    SharedPreferences sharedPreferences,
  ) async {
    try {
      await sharedPreferences.setString(
        _qrCodeStyleSettingsKey,
        jsonEncode(value.toJsonMap()),
      );
    } catch (e, stackTrace) {
      log(
        'Error while saving epc data',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

extension _JsonExtensions on Map<String, dynamic> {
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

extension _QrCodeStyleSettingsExtensions on QrCodeStyleSettings {
  Map<String, dynamic> toJsonMap() {
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

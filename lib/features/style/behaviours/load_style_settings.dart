import 'dart:convert';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/style/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/json_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadStyleSettings extends BehaviourWithoutInput<void> {
  LoadStyleSettings({
    super.monitor,
    required this.sharedPreferences,
    required this.styleSettingsNotifier,
  });

  final SharedPreferences sharedPreferences;
  final StyleSettingsNotifier styleSettingsNotifier;

  @override
  String get description => 'loading style settings';

  @override
  Future<void> action(BehaviourTrack? track) {
    final jsonData = sharedPreferences.get(qrCodeStyleSettingsKey) as String?;
    if (jsonData == null) {
      return Future.value();
    }
    final map = jsonDecode(jsonData) as Map<String, dynamic>;
    styleSettingsNotifier.value = map.toStyleSettings();
    return Future.value();
  }
}

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

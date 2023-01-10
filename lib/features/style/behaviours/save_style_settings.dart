import 'dart:convert';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveStyleSettings extends BehaviourWithoutInput<void> {
  SaveStyleSettings({
    super.monitor,
    required this.sharedPreferences,
    required this.styleSettingsNotifier,
  });

  final SharedPreferences sharedPreferences;
  final StyleSettingsNotifier styleSettingsNotifier;

  @override
  String get description => 'saving style settings';

  @override
  Future<void> action(BehaviourTrack? track) async {
    final map = styleSettingsNotifier.value.toJson();
    await sharedPreferences.setString(
      sharedPreferences.qrCodeStyleSettingsKey,
      jsonEncode(map),
    );
  }
}

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

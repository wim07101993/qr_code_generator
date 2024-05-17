import 'dart:async';
import 'dart:convert';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/json_extensions.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadStyleSettings extends BehaviourWithoutInput<void> {
  LoadStyleSettings({
    super.monitor,
    required this.sharedPreferences,
    required this.styleSettingsNotifier,
    required this.getEmbeddedImage,
  });

  final SharedPreferences sharedPreferences;
  final StyleSettingsNotifier styleSettingsNotifier;
  final GetEmbeddedImage getEmbeddedImage;

  @override
  String get description => 'loading style settings';

  @override
  FutureOr<void> action(BehaviourTrack? track) async {
    final jsonData = sharedPreferences
        .get(sharedPreferences.qrCodeStyleSettingsKey) as String?;
    final embeddedImage =
        await getEmbeddedImage().thenWhen((_) => null, (image) => image);

    if (jsonData == null && embeddedImage == null) {
      return;
    }

    if (jsonData == null) {
      styleSettingsNotifier.value = StyleSettings(embeddedImage: embeddedImage);
      return;
    }

    final map = jsonDecode(jsonData) as Map<String, dynamic>;
    styleSettingsNotifier.value = map.toStyleSettings(
      embeddedImage: embeddedImage,
    );
  }
}

extension _JsonExtensions on Map<String, dynamic> {
  StyleSettings toStyleSettings({ImageProvider? embeddedImage}) {
    return StyleSettings(
      backgroundColor:
          getColor('backgroundColor') ?? StyleSettings.defaultBackgroundColor,
      dataModuleStyle: getObject('dataModuleStyle')?.toQrDataModuleStyle() ??
          StyleSettings.defaultDataModuleStyle,
      embeddedImage: embeddedImage,
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

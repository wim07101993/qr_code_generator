import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/data/json_extensions.dart';
import 'package:qr_code_generator/qr_code_style/notifiers/qr_code_style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_extensions.loading.dart';
part 'shared_preferences_extensions.saving.dart';

const _qrCodeStyleSettingsKey = 'qrCodeStyleData';

extension EpcSharedPreferencesExtensions on SharedPreferences {
  QrCodeStyleSettings? loadQrCodeStyleSettings() {
    try {
      final jsonData = get(_qrCodeStyleSettingsKey) as String?;
      if (jsonData == null) {
        return null;
      }
      final map = jsonDecode(jsonData) as Map<String, dynamic>;
      return map.toQrCodeStyleSettings();
    } catch (e, stackTrace) {
      log(
        'Error while reading previously stored qrCodeStyle data',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> saveQrCodeStyleSettings(QrCodeStyleSettings settings) async {
    try {
      final map = settings.toJson();
      await setString(_qrCodeStyleSettingsKey, jsonEncode(map));
    } catch (e, stackTrace) {
      log(
        'Error while reading previously stored qrCodeStyle data',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

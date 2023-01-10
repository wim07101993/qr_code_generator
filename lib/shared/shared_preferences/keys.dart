import 'package:shared_preferences/shared_preferences.dart';

extension EpcSharedPreferencesExtensions on SharedPreferences {
  String get qrCodeStyleSettingsKey => 'qrCodeStyleData';
  String get epcDataKey => 'epcData';
  String get lastUsedQrCode => 'lastUsedQrCode';
}

import 'package:shared_preferences/shared_preferences.dart';

extension EpcSharedPreferencesExtensions on SharedPreferences {
  String get epcDataKey => 'epcData';
}

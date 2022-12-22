import 'dart:convert';
import 'dart:developer';

import 'package:qr_code_generator/data/json_extensions.dart';
import 'package:qr_code_generator/epc/notifiers/epc_character_set.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/epc/notifiers/epc_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_extensions.loading.dart';
part 'shared_preferences_extensions.saving.dart';

const _epcDataKey = 'epcData';

extension EpcSharedPreferencesExtensions on SharedPreferences {
  EpcData? loadEpcData() {
    try {
      final jsonData = get(_epcDataKey) as String?;
      if (jsonData == null) {
        return null;
      }
      final map = jsonDecode(jsonData) as Map<String, dynamic>;
      return map.toEpcData();
    } catch (e, stackTrace) {
      log(
        'Error while reading previously stored epc data',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> saveEpcData(EpcData data) async {
    try {
      final map = data.toJson();
      await setString(_epcDataKey, jsonEncode(map));
    } catch (e, stackTrace) {
      log(
        'Error while reading previously stored epc data',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

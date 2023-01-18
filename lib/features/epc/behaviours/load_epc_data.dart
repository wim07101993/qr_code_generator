import 'dart:convert';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/shared/json_extensions.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadEpcData extends BehaviourWithoutInput<void> {
  LoadEpcData({
    super.monitor,
    required this.sharedPreferences,
    required this.epcDataNotifier,
  });

  final SharedPreferences sharedPreferences;
  final EpcDataNotifier epcDataNotifier;

  @override
  String get description => 'loading epc data';

  @override
  Future<void> action(BehaviourTrack? track) {
    final jsonData =
        sharedPreferences.get(sharedPreferences.epcDataKey) as String?;
    if (jsonData == null) {
      return Future.value();
    }
    final map = jsonDecode(jsonData) as Map<String, dynamic>;
    epcDataNotifier.value = map.toEpcData();
    return Future.value();
  }
}

extension JsonExtensions on Map<String, dynamic> {
  EpcData toEpcData() {
    return EpcData(
      amount: getDouble('amount') ?? EpcData.defaultAmount,
      beneficiaryName:
          getString('beneficiaryName') ?? EpcData.defaultBeneficiaryName,
      iban: getString('iban') ?? EpcData.defaultIban,
      version: getString('version')?.toEpcVersion() ?? EpcData.defaultVersion,
      useStructuredRemittanceInfo:
          getBool('useStructuredRemittanceInfo') ?? false,
      remittanceInfo: getString('remittanceInfo'),
      originatorInfo: getString('originatorInfo'),
      bic: getString('bic'),
      characterSet: getString('characterSet')?.toEpcCharacterSet() ??
          EpcData.defaultCharacterSet,
      purpose: getString('purpose'),
    );
  }
}

extension StringExtensions on String {
  EpcVersion toEpcVersion() {
    return EpcVersion.values.firstWhere(
      (v) => v.name == this,
      orElse: () => EpcVersion.version2,
    );
  }

  EpcCharacterSet toEpcCharacterSet() {
    return EpcCharacterSet.values.firstWhere(
      (v) => v.name == this,
      orElse: () => EpcCharacterSet.utf8,
    );
  }
}

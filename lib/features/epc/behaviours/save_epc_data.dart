import 'dart:convert';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/epc/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveEpcData extends BehaviourWithoutInput<void> {
  SaveEpcData({
    super.monitor,
    required this.sharedPreferences,
    required this.epcDataNotifier,
  });

  final SharedPreferences sharedPreferences;
  final EpcDataNotifier epcDataNotifier;

  @override
  String get description => 'saving epc data';

  @override
  Future<void> action(BehaviourTrack? track) {
    final map = epcDataNotifier.value.toJson();
    return sharedPreferences.setString(
      sharedPreferences.epcDataKey,
      jsonEncode(map),
    );
  }
}

extension _EpcDataExtensions on EpcData {
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'iban': iban,
      'beneficiaryName': beneficiaryName,
      'purpose': purpose,
      'characterSet': characterSet.name,
      'bic': bic,
      'originatorInfo': originatorInfo,
      'remittanceInfo': remittanceInfo,
      'useStructuredRemittanceInfo': useStructuredRemittanceInfo,
      'version': version.name,
    };
  }
}

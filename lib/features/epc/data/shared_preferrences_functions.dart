import 'dart:convert';
import 'dart:developer';

import 'package:qr_code_generator/features/epc/notifiers/epc_character_set.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension EpcSharedPreferencesExtensions on SharedPreferences {
  static const epcDataKey = 'epcData';

  Future<void> loadEpcDataTo(EpcData data) async {
    try {
      final jsonData = get(epcDataKey) as String?;
      if (jsonData == null) {
        return;
      }
      final map = jsonDecode(jsonData) as Map<String, dynamic>;
      data.amount = map['amount'] as String;
      data.iban = map['iban'] as String;
      data.beneficiaryName = map['beneficiaryName'] as String;
      data.purpose = map['purpose'] as String?;
      data.characterSet = EpcCharacterSet.values.firstWhere(
        (v) => v.name == map['characterSet'] as String,
        orElse: () => EpcCharacterSet.utf8,
      );
      data.bic = map['bic'] as String?;
      data.originatorInfo = map['originatorInfo'] as String?;
      data.remittanceInfo = map['remittanceInfo'] as String?;
      data.useStructuredRemittanceInfo =
          map['useStructuredRemittanceInfo'] as bool;
      data.version = EpcVersion.values.firstWhere(
        (v) => v.name == map['version'] as String,
        orElse: () => EpcVersion.version2,
      );
    } catch (e, stackTrace) {
      log(
        'Error while reading previously stored epc data',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> saveEpcData(EpcData data) {
    return setString(
      epcDataKey,
      jsonEncode({
        'amount': data.amount,
        'iban': data.iban,
        'beneficiaryName': data.beneficiaryName,
        'purpose': data.purpose,
        'characterSet': data.characterSet.toString(),
        'bic': data.bic,
        'originatorInfo': data.originatorInfo,
        'remittanceInfo': data.remittanceInfo,
        'useStructuredRemittanceInfo': data.useStructuredRemittanceInfo,
        'version': data.version.toString(),
      }),
    );
  }
}

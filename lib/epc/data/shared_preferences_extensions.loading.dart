part of 'shared_preferences_extensions.dart';

extension _JsonExtensions on Map<String, dynamic> {
  EpcData toEpcData() {
    return EpcData(
      amount: getString('amount') ?? EpcData.defaultAmount,
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

extension _StringExtensions on String {
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

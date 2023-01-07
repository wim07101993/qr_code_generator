part of 'shared_preferences_extensions.dart';

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

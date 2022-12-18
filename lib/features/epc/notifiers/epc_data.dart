import 'package:flutter/foundation.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_character_set.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_version.dart';

class EpcData extends ChangeNotifier implements ValueListenable<String> {
  EpcData({
    required String amount,
    required String iban,
    required String beneficiaryName,
    EpcVersion version = EpcVersion.version2,
    String? bic,
    String? purpose,
    EpcCharacterSet characterSet = EpcCharacterSet.utf8,
    String? remittanceInfo,
    bool useStructuredRemittanceInfo = false,
    String? originatorInfo,
  })  : assert(EpcData.validateVersion(version, bic)?.throwException() == null),
        assert(EpcData.validateAmount(amount)?.throwException() == null),
        assert(EpcData.validateIban(iban)?.throwException() == null),
        assert(
          EpcData.validateBeneficiaryName(beneficiaryName)?.throwException() ==
              null,
        ),
        assert(EpcData.validateBic(bic, version)?.throwException() == null),
        assert(EpcData.validatePurpose(purpose)?.throwException() == null),
        assert(
          EpcData.validateRemittanceInfo(
                remittanceInfo,
                isStructured: useStructuredRemittanceInfo,
              ) ==
              null,
        ),
        assert(EpcData.validateOriginatorInfo(originatorInfo) == null),
        _version = version,
        _amount = amount,
        _iban = iban,
        _beneficiaryName = beneficiaryName,
        _bic = bic,
        _purpose = purpose,
        _characterSet = characterSet,
        _remittanceInfo = remittanceInfo,
        _useStructuredRemittanceInfo = useStructuredRemittanceInfo,
        _originatorInfo = originatorInfo;

  static const String serviceTag = 'BCD';
  static const String identification = 'SCT';

  static final RegExp alphaNumericRegex = RegExp(r'^[A-Za-z0-9]*$');
  static final RegExp nameRegex = RegExp(r'^[A-Za-z0-9 ]*$');
  static final RegExp amountRegex = RegExp(r'^[0-9]+(?:\.[0-9]{1,2})?$');

  EpcVersion _version;
  EpcVersion get version => _version;
  set version(EpcVersion value) {
    if (value == version) {
      return;
    }
    validateVersion(value, bic)?.throwException();
    _version = value;
    notifyListeners();
  }

  EpcCharacterSet _characterSet;
  EpcCharacterSet get characterSet => _characterSet;
  set characterSet(EpcCharacterSet value) {
    if (value == version) {
      return;
    }
    _characterSet = value;
    notifyListeners();
  }

  String _beneficiaryName;
  String get beneficiaryName => _beneficiaryName;
  set beneficiaryName(String value) {
    if (value == _beneficiaryName) {
      return;
    }
    validateBeneficiaryName(value)?.throwException();
    _beneficiaryName = value;
    notifyListeners();
  }

  String? _bic;
  String? get bic => _bic;
  set bic(String? value) {
    if (value == _bic) {
      return;
    }
    validateBic(value, version)?.throwException();
    _bic = value;
    notifyListeners();
  }

  String _iban;
  String get iban => _iban;
  set iban(String value) {
    if (value == _iban) {
      return;
    }
    validateIban(value)?.throwException();
    _iban = value;
    notifyListeners();
  }

  String _amount;
  String get amount => _amount;
  set amount(String value) {
    if (value == _amount) {
      return;
    }
    validateAmount(value)?.throwException();
    _amount = value;
    notifyListeners();
  }

  String? _purpose;
  String? get purpose => _purpose;
  set purpose(String? value) {
    if (value == _purpose) {
      return;
    }
    validatePurpose(value)?.throwException();
    _purpose = value;
    notifyListeners();
  }

  String? _remittanceInfo;
  String? get remittanceInfo => _remittanceInfo;
  set remittanceInfo(String? value) {
    if (value == _remittanceInfo) {
      return;
    }
    validateRemittanceInfo(value, isStructured: useStructuredRemittanceInfo)
        ?.throwException();
    _remittanceInfo = value;
    notifyListeners();
  }

  bool _useStructuredRemittanceInfo;
  bool get useStructuredRemittanceInfo => _useStructuredRemittanceInfo;
  set useStructuredRemittanceInfo(bool value) {
    if (value == _useStructuredRemittanceInfo) {
      return;
    }
    validateRemittanceInfo(remittanceInfo, isStructured: value)
        ?.throwException();
    _useStructuredRemittanceInfo = value;
    notifyListeners();
  }

  String? _originatorInfo;
  String? get originatorInfo => _originatorInfo;
  set originatorInfo(String? value) {
    if (value == _originatorInfo) {
      return;
    }
    validateOriginatorInfo(value)?.throwException();
    _originatorInfo = value;
    notifyListeners();
  }

  @override
  String get value {
    return [
      serviceTag,
      version.toEpcDataString(),
      characterSet.toEpcDataString(),
      identification,
      bic,
      beneficiaryName,
      iban,
      'EUR$amount',
      purpose,
      // TODO structured vs unstructured remittance info
      remittanceInfo,
      originatorInfo
    ].map((s) => s ?? '').join('\n').trim();
  }

  static String? validateVersion(EpcVersion? value, String? bic) {
    if (value == null) {
      return 'Please enter a version.';
    }
    if (value == EpcVersion.version1 && bic == null) {
      return 'Version 1 requires a BIC';
    }
    return null;
  }

  static String? validateBeneficiaryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Beneficiary name cannot be empty';
    }
    if (value.length > 70) {
      return 'Beneficiary name can only be 70 characters.';
    }
    if (!nameRegex.hasMatch(value)) {
      return 'The name can only contain alpha-numeric characters and spaces.';
    }
    return null;
  }

  static String? validateBic(String? value, EpcVersion version) {
    if (value == null || value.isEmpty) {
      return version == EpcVersion.version1
          ? 'The BIC name cannot be empty in version 1.'
          : null;
    }
    if (alphaNumericRegex.hasMatch(value)) {
      return 'A BIC can only contain alpha-numeric characters.';
    }
    return null;
  }

  static String? validateIban(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a IBAN.';
    }
    if (value.length > 34) {
      return 'An IBAN can only be 34 characters';
    }
    if (!alphaNumericRegex.hasMatch(value)) {
      return 'Please enter a valid IBAN';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }
    if (value.length > 12 || (!value.contains('.')) && value.length > 9) {
      return 'The amount must be less than 999999999.99';
    }
    if (!amountRegex.hasMatch(value)) {
      return 'Please enter a valid amount (use a dot as decimal separator and only maximum 2 decimal numbers are allowed)';
    }
    return null;
  }

  static String? validatePurpose(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > 4) {
      return 'The purpose can only be 4 characters';
    }
    if (!alphaNumericRegex.hasMatch(value)) {
      return 'The purpose can only contain alpha-numeric characters';
    }
    return null;
  }

  static String? validateRemittanceInfo(
    String? value, {
    required bool isStructured,
  }) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (isStructured && value.length > 35) {
      return 'Structured remittance info can only contain 35 characters';
    } else if (value.length > 140) {
      return 'Remittance info can only contain 140 characters';
    }
    if (!alphaNumericRegex.hasMatch(value)) {
      return 'Remittance info can only be alpha-numeric characters';
    }
    return null;
  }

  static String? validateOriginatorInfo(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > 70) {
      return 'Originator info can only be 70 characters';
    }
    if (!alphaNumericRegex.hasMatch(value)) {
      return 'Originator info can only contain alpha-numeric characters';
    }
    return null;
  }
}

extension _ErrorExtensions on String {
  String? throwException() {
    throw Exception(this);
  }
}

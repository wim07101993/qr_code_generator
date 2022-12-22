import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc/notifiers/epc_character_set.dart';
import 'package:qr_code_generator/epc/notifiers/epc_version.dart';

class EpcDataNotifier extends ChangeNotifier
    implements ValueListenable<EpcData?> {
  EpcDataNotifier() {
    for (final notifier in notifiers) {
      notifier.addListener(notifyListeners);
    }
  }

  final TextEditingController amount =
      TextEditingController(text: EpcData.defaultAmount);
  final TextEditingController iban =
      TextEditingController(text: EpcData.defaultIban);
  final TextEditingController beneficiaryName =
      TextEditingController(text: EpcData.defaultBeneficiaryName);
  final TextEditingController bic = TextEditingController();
  final TextEditingController purpose = TextEditingController();
  final TextEditingController remittanceInfo = TextEditingController();
  final TextEditingController originatorInfo = TextEditingController();
  final ValueNotifier<EpcCharacterSet> characterSet =
      ValueNotifier(EpcData.defaultCharacterSet);
  final ValueNotifier<EpcVersion> version =
      ValueNotifier(EpcData.defaultVersion);
  final ValueNotifier<bool> useStructuredRemittanceInfo = ValueNotifier(false);

  List<ChangeNotifier> get notifiers => [
        amount,
        iban,
        beneficiaryName,
        bic,
        purpose,
        remittanceInfo,
        originatorInfo,
        characterSet,
        version,
        useStructuredRemittanceInfo,
      ];

  @override
  EpcData? get value {
    if (EpcData.validateAmount(amount.text) != null ||
        EpcData.validateIban(iban.text) != null ||
        EpcData.validateBeneficiaryName(beneficiaryName.text) != null ||
        EpcData.validateOriginatorInfo(originatorInfo.text) != null ||
        EpcData.validateRemittanceInfo(
              remittanceInfo.text,
              isStructured: useStructuredRemittanceInfo.value,
            ) !=
            null ||
        EpcData.validatePurpose(purpose.text) != null ||
        EpcData.validateBic(bic.text, version.value) != null) {
      return null;
    }
    return EpcData(
      amount: amount.text,
      iban: iban.text,
      beneficiaryName: beneficiaryName.text,
      originatorInfo: originatorInfo.text,
      useStructuredRemittanceInfo: useStructuredRemittanceInfo.value,
      characterSet: characterSet.value,
      purpose: purpose.text,
      bic: bic.text,
      remittanceInfo: remittanceInfo.text,
      version: version.value,
    );
  }

  set value(EpcData? epcData) {
    amount.text = epcData?.amount ?? EpcData.defaultAmount;
    iban.text = epcData?.iban ?? EpcData.defaultIban;
    beneficiaryName.text =
        epcData?.beneficiaryName ?? EpcData.defaultBeneficiaryName;
    originatorInfo.text = epcData?.originatorInfo ?? '';
    useStructuredRemittanceInfo.value =
        epcData?.useStructuredRemittanceInfo ?? false;
    characterSet.value = epcData?.characterSet ?? EpcData.defaultCharacterSet;
    purpose.text = epcData?.purpose ?? '';
    bic.text = epcData?.bic ?? '';
    remittanceInfo.text = epcData?.remittanceInfo ?? '';
    version.value = epcData?.version ?? EpcData.defaultVersion;
  }

  @override
  void dispose() {
    for (final notifier in notifiers) {
      notifier.removeListener(notifyListeners);
      notifier.dispose();
    }
    super.dispose();
  }
}

class EpcData {
  static const String defaultAmount = '3.14';
  static const String defaultIban = 'BE10779597575204';
  static const String defaultBeneficiaryName = 'Wim Van Laer';
  static const EpcVersion defaultVersion = EpcVersion.version2;
  static const EpcCharacterSet defaultCharacterSet = EpcCharacterSet.utf8;

  EpcData({
    required this.amount,
    required this.iban,
    required this.beneficiaryName,
    this.version = defaultVersion,
    this.bic,
    this.purpose,
    this.characterSet = defaultCharacterSet,
    this.remittanceInfo,
    this.useStructuredRemittanceInfo = false,
    this.originatorInfo,
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
        assert(EpcData.validateOriginatorInfo(originatorInfo) == null);

  EpcData.defaultValue()
      : this(
          beneficiaryName: defaultBeneficiaryName,
          iban: defaultIban,
          amount: defaultAmount,
        );

  static const String serviceTag = 'BCD';
  static const String identification = 'SCT';

  static final RegExp alphaNumericRegex = RegExp(r'^[A-Za-z0-9]*$');
  static final RegExp nameRegex = RegExp(r'^[A-Za-z0-9 ]*$');
  static final RegExp unstructuredRemittanceInfoRegex =
      RegExp(r'^[A-Za-z0-9 ]*$');
  static final RegExp originatorInfoRegex = RegExp(r'^[A-Za-z0-9 ]*$');
  // static final RegExp amountRegex = RegExp(r'^[0-9]+$');
  static final RegExp amountRegex = RegExp(r'^[0-9]+(?:\.[0-9]{1,2})?$');

  final EpcVersion version;
  final EpcCharacterSet characterSet;
  final String beneficiaryName;
  final String? bic;
  final String iban;
  final String amount;
  final String? purpose;
  final String? remittanceInfo;
  final bool useStructuredRemittanceInfo;
  final String? originatorInfo;

  String get qrData {
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
      remittanceInfo,
      originatorInfo
    ].map((s) => s ?? '').join('\n').trim();
  }

  EpcData copyWithAmount(String amount) {
    return EpcData(
      version: version,
      characterSet: characterSet,
      beneficiaryName: beneficiaryName,
      bic: bic,
      iban: iban,
      amount: amount,
      purpose: purpose,
      remittanceInfo: remittanceInfo,
      useStructuredRemittanceInfo: useStructuredRemittanceInfo,
      originatorInfo: originatorInfo,
    );
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
    if (isStructured) {
      if (value.length > 35) {
        return 'Structured remittance info can only contain 35 characters';
      } else if (!alphaNumericRegex.hasMatch(value)) {
        return 'Remittance info can only be alpha-numeric characters';
      }
    } else {
      if (value.length > 140) {
        return 'Remittance info can only contain 140 characters';
      } else if (!unstructuredRemittanceInfoRegex.hasMatch(value)) {
        return 'Remittance info can only be alpha-numeric characters or spaces';
      }
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
    if (!originatorInfoRegex.hasMatch(value)) {
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_character_set.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_version.dart';
import 'package:qr_code_generator/shared/function_tree_extensions.dart';

export 'package:qr_code_generator/features/epc/notifiers/epc_character_set.dart';
export 'package:qr_code_generator/features/epc/notifiers/epc_version.dart';

class EpcDataNotifier extends ChangeNotifier
    implements ValueListenable<EpcData> {
  EpcDataNotifier() {
    for (final notifier in notifiers) {
      notifier.addListener(notifyListeners);
    }
  }

  final TextEditingController amount = TextEditingController(
    text: (EpcData.defaultAmountInCents / 100).toString(),
  );
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

  EpcData _lastValidValue = EpcData(
    amountInCents: EpcData.defaultAmountInCents,
    iban: EpcData.defaultIban,
    beneficiaryName: EpcData.defaultBeneficiaryName,
  );

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
  EpcData get value {
    final amountInCents = amount.text.tryConvertToAmountInCents();
    final isValid = EpcData.validateAmountInCents(amountInCents) == null &&
        EpcData.validateIban(iban.text) == null &&
        EpcData.validateBeneficiaryName(beneficiaryName.text) == null &&
        EpcData.validateOriginatorInfo(originatorInfo.text) == null &&
        EpcData.validateRemittanceInfo(
              remittanceInfo.text,
              isStructured: useStructuredRemittanceInfo.value,
            ) ==
            null &&
        EpcData.validatePurpose(purpose.text) == null &&
        EpcData.validateBic(bic.text, version.value) == null;
    if (isValid) {
      _lastValidValue = EpcData(
        amountInCents: amountInCents!,
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
    return _lastValidValue;
  }

  set value(EpcData? epcData) {
    final amountInCents =
        epcData?.amountInCents ?? EpcData.defaultAmountInCents;
    amount.text = (amountInCents / 100).toString();
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
  static const int defaultAmountInCents = 314;
  static const String defaultIban = 'BE10779597575204';
  static const String defaultBeneficiaryName = 'Wim Van Laer';
  static const EpcVersion defaultVersion = EpcVersion.version2;
  static const EpcCharacterSet defaultCharacterSet = EpcCharacterSet.utf8;

  EpcData({
    required this.amountInCents,
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
        assert(
          EpcData.validateAmountInCents(amountInCents)?.throwException() ==
              null,
        ),
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
          amountInCents: defaultAmountInCents,
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
  final int amountInCents;
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
      'EUR${amountInCents ~/ 100}.${amountInCents % 100}',
      purpose,
      remittanceInfo,
      originatorInfo,
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

  static String? validateAmountInCents(int? value) {
    if (value == null) {
      return 'Please enter an amount';
    }
    if (value >= 100000000000) {
      return 'The amount must be less than 99999999999';
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

extension StringExtensions on String {
  String? throwException() {
    throw Exception(this);
  }

  int? tryConvertToAmountInCents() {
    final amount = tryInterpret();
    if (amount == null) {
      return null;
    }
    return (amount * 100).round();
  }
}

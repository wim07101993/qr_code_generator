// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get ibanSettingHelperText =>
      'The IBAN number of the bank account to send money too.';

  @override
  String get bicSettingHelperText =>
      'The BIC number of the bank to send money too.';

  @override
  String get beneficiaryName => 'Beneficiary name';

  @override
  String get beneficiaryNameSettingHelperText =>
      'The name of the receiver of the money.';

  @override
  String get version => 'Version';

  @override
  String get version1 => 'Version 1';

  @override
  String get version2 => 'Version 2';

  @override
  String get versionSettingHelperText =>
      'The version of the EPC (Payment) QR-code';

  @override
  String get purpose => 'Purpose';

  @override
  String get purposeSettingHelperText => 'Purpose of the SEPA credit transfer.';

  @override
  String get useStructuredRemittanceInfoCheckboxLabel =>
      'Use structured remittance info';

  @override
  String get remittanceInfo => 'Remittance information';

  @override
  String get remittanceInfoSettingHelperText =>
      'Information about the payment.';

  @override
  String get originatorInfo => 'Originator information';

  @override
  String get originatorInfoSettingHelperText =>
      'Information about the originator.';

  @override
  String get saveQrDialogTitle => 'Save QR-code';

  @override
  String get qrCode => 'QR-code';

  @override
  String get epcPaymentDrawerOption => 'Payment request (EPC)';

  @override
  String get textQrDrawerOption => 'Text';

  @override
  String get qrCodeStyleDrawerOption => 'QR-code style';

  @override
  String get aboutDrawerOption => 'About';

  @override
  String get qrCodeStyleScreenTitle => 'QR-code style';

  @override
  String get qrDataModuleStyle => 'QR data module style';

  @override
  String get qrEyeStyle => 'QR eye style';

  @override
  String get shape => 'Shape';

  @override
  String get square => 'Square';

  @override
  String get circle => 'Circle';

  @override
  String get color => 'Color';

  @override
  String get background => 'Background';

  @override
  String get image => 'Image';

  @override
  String get none => 'none';

  @override
  String get removeImageButtonLabel => 'Remove';

  @override
  String get selectImageFileButtonLabel => 'Select file';

  @override
  String get textInputHelperText => 'Text to encode in the QR-code';

  @override
  String get generalErrorMessage => 'An error occurred';

  @override
  String get fileDoesNotExistsErrorMessage => 'The file does not exist';

  @override
  String get couldNotLoadImageErrorMessage => 'Could not load image';

  @override
  String get changeColor => 'Change color';

  @override
  String get selectColor => 'Select color';

  @override
  String get cancel => 'Cancel';
}

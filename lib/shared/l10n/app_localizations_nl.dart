// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get ibanSettingHelperText =>
      'Het IBAN nummer van de bankrekening waar het geld naar overgesreven moet worden.';

  @override
  String get bicSettingHelperText =>
      'Het BIC nummer van de bank waar het geld naar overgesreven moet worden.';

  @override
  String get beneficiaryName => 'Naam van de ontvanger';

  @override
  String get beneficiaryNameSettingHelperText =>
      'Naam van de persoon naar wie het geld moet worden overgeschreven';

  @override
  String get version => 'Versie';

  @override
  String get version1 => 'Versie 1';

  @override
  String get version2 => 'Versie 2';

  @override
  String get versionSettingHelperText =>
      'De versie van de EPC (betaal) QR-code';

  @override
  String get purpose => 'Doel';

  @override
  String get purposeSettingHelperText =>
      'Het doel van de SEPA credit transactie.';

  @override
  String get useStructuredRemittanceInfoCheckboxLabel =>
      'Gebruik gestructureerde mededeling';

  @override
  String get remittanceInfo => 'Mededeling';

  @override
  String get remittanceInfoSettingHelperText =>
      'Mededeling van de betaling (gestructureerd of vrij).';

  @override
  String get originatorInfo => 'Betaler informatie';

  @override
  String get originatorInfoSettingHelperText =>
      'Informatie over de persoon die het geld overschrijft.';

  @override
  String get saveQrDialogTitle => 'Save QR-code';

  @override
  String get qrCode => 'QR-code';

  @override
  String get epcPaymentDrawerOption => 'Betaalverzoek (EPC)';

  @override
  String get textQrDrawerOption => 'Tekst';

  @override
  String get qrCodeStyleDrawerOption => 'QR-code stijl';

  @override
  String get aboutDrawerOption => 'Over deze app';

  @override
  String get qrCodeStyleScreenTitle => 'QR-code stijl';

  @override
  String get qrDataModuleStyle => 'QR data module stijl';

  @override
  String get qrEyeStyle => 'QR oog stijl';

  @override
  String get shape => 'Vorm';

  @override
  String get square => 'Vierkant';

  @override
  String get circle => 'Rond';

  @override
  String get color => 'Kleur';

  @override
  String get background => 'Achtergrond';

  @override
  String get image => 'Afbeelding';

  @override
  String get none => 'geen';

  @override
  String get removeImageButtonLabel => 'Verwijderen';

  @override
  String get selectImageFileButtonLabel => 'Bestand kiezen';

  @override
  String get textInputHelperText => 'Tekst om te coderen in de QR-code';

  @override
  String get generalErrorMessage => 'An error occurred';

  @override
  String get fileDoesNotExistsErrorMessage => 'The file does not exist';

  @override
  String get couldNotLoadImageErrorMessage => 'Could not load image';

  @override
  String get changeColor => 'Verander kleur';

  @override
  String get selectColor => 'Kleur selecteren';

  @override
  String get cancel => 'Annuleren';
}

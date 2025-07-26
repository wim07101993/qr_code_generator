import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl')
  ];

  /// Helper text for the IBAN input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'The IBAN number of the bank account to send money too.'**
  String get ibanSettingHelperText;

  /// Helper text for the BIC input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'The BIC number of the bank to send money too.'**
  String get bicSettingHelperText;

  /// No description provided for @beneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary name'**
  String get beneficiaryName;

  /// Helper text for the beneficiary name input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'The name of the receiver of the money.'**
  String get beneficiaryNameSettingHelperText;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @version1.
  ///
  /// In en, this message translates to:
  /// **'Version 1'**
  String get version1;

  /// No description provided for @version2.
  ///
  /// In en, this message translates to:
  /// **'Version 2'**
  String get version2;

  /// Helper text for the epc version input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'The version of the EPC (Payment) QR-code'**
  String get versionSettingHelperText;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// Helper text for the purpose input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'Purpose of the SEPA credit transfer.'**
  String get purposeSettingHelperText;

  /// No description provided for @useStructuredRemittanceInfoCheckboxLabel.
  ///
  /// In en, this message translates to:
  /// **'Use structured remittance info'**
  String get useStructuredRemittanceInfoCheckboxLabel;

  /// No description provided for @remittanceInfo.
  ///
  /// In en, this message translates to:
  /// **'Remittance information'**
  String get remittanceInfo;

  /// Helper text for the remittance info input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'Information about the payment.'**
  String get remittanceInfoSettingHelperText;

  /// No description provided for @originatorInfo.
  ///
  /// In en, this message translates to:
  /// **'Originator information'**
  String get originatorInfo;

  /// Helper text for the originator info input field on the settings sheet of the epc qr-code
  ///
  /// In en, this message translates to:
  /// **'Information about the originator.'**
  String get originatorInfoSettingHelperText;

  /// No description provided for @saveQrDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Save QR-code'**
  String get saveQrDialogTitle;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR-code'**
  String get qrCode;

  /// No description provided for @epcPaymentDrawerOption.
  ///
  /// In en, this message translates to:
  /// **'Payment request (EPC)'**
  String get epcPaymentDrawerOption;

  /// No description provided for @textQrDrawerOption.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textQrDrawerOption;

  /// No description provided for @qrCodeStyleDrawerOption.
  ///
  /// In en, this message translates to:
  /// **'QR-code style'**
  String get qrCodeStyleDrawerOption;

  /// No description provided for @aboutDrawerOption.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutDrawerOption;

  /// No description provided for @qrCodeStyleScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'QR-code style'**
  String get qrCodeStyleScreenTitle;

  /// No description provided for @qrDataModuleStyle.
  ///
  /// In en, this message translates to:
  /// **'QR data module style'**
  String get qrDataModuleStyle;

  /// No description provided for @qrEyeStyle.
  ///
  /// In en, this message translates to:
  /// **'QR eye style'**
  String get qrEyeStyle;

  /// No description provided for @shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get shape;

  /// No description provided for @square.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get square;

  /// No description provided for @circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get circle;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get none;

  /// No description provided for @removeImageButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeImageButtonLabel;

  /// No description provided for @selectImageFileButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectImageFileButtonLabel;

  /// Helper text for the input field on the text qr-code screen
  ///
  /// In en, this message translates to:
  /// **'Text to encode in the QR-code'**
  String get textInputHelperText;

  /// No description provided for @generalErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get generalErrorMessage;

  /// No description provided for @fileDoesNotExistsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The file does not exist'**
  String get fileDoesNotExistsErrorMessage;

  /// No description provided for @couldNotLoadImageErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not load image'**
  String get couldNotLoadImageErrorMessage;

  /// No description provided for @changeColor.
  ///
  /// In en, this message translates to:
  /// **'Change color'**
  String get changeColor;

  /// Text on the button to select the color in the color dialog
  ///
  /// In en, this message translates to:
  /// **'Select color'**
  String get selectColor;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

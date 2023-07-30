import 'package:flutter/material.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

void showException(BuildContext context, Exception exception) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(exception.getTranslatedErrorMessage(context))),
  );
}

extension ExceptionLocalizationExtensions on Exception {
  String getTranslatedErrorMessage(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return s.generalErrorMessage;
  }
}

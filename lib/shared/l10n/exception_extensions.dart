import 'package:flutter/material.dart';
import 'package:qr_code_generator/home/behaviours/get_local_image.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

void showException(BuildContext context, Exception exception) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(exception.getTranslatedErrorMessage(context))),
  );
}

extension ExceptionLocalizationExtensions on Exception {
  String getTranslatedErrorMessage(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    switch (runtimeType) {
      case FileDoesNotExistsException x_:
        return s.fileDoesNotExistsErrorMessage;
      case CouldNotLoadImageException _:
        return s.couldNotLoadImageErrorMessage;
    }
    return s.generalErrorMessage;
  }
}

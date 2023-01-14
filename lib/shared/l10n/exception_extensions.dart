import 'package:flutter/material.dart';
import 'package:qr_code_generator/home/behaviours/get_local_image.dart';

void showException(BuildContext context, Exception exception) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(exception.getTranslatedErrorMessage(context))),
  );
}

extension ExceptionLocalizationExtensions on Exception {
  String getTranslatedErrorMessage(BuildContext context) {
    switch (runtimeType) {
      case FileDoesNotExistsException:
        return 'TODO ';
      case CouldNotLoadImageException:
        return 'TODO';
    }
    return 'TODO';
  }
}

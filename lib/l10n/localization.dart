import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension QrDataModuleShapeExtension on QrDataModuleShape {
  String translate(AppLocalizations s) {
    switch (this) {
      case QrDataModuleShape.square:
        return s.square;
      case QrDataModuleShape.circle:
        return s.circle;
    }
  }
}

extension QrEyeShapeExtension on QrEyeShape {
  String translate(AppLocalizations s) {
    switch (this) {
      case QrEyeShape.square:
        return s.square;
      case QrEyeShape.circle:
        return s.circle;
    }
  }
}

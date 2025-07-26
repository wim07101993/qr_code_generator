import 'package:qr_code_generator/features/epc/notifiers/epc_version.dart';
import 'package:qr_code_generator/shared/l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

export 'package:qr_code_generator/shared/l10n/app_localizations.dart';

extension EpcVersionExtension on EpcVersion {
  String translate(AppLocalizations s) {
    switch (this) {
      case EpcVersion.version1:
        return s.version1;
      case EpcVersion.version2:
        return s.version2;
    }
  }
}

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

import 'package:auto_route/auto_route.dart';
import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/features/epc/epc_feature.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/state_management/value_stream.dart';

// enum QrCodeType {
//   text(TextQrCodeRoute()),
//   epc(EpcQrCodeRoute());
//
//   const QrCodeType(this.route);
//
//   final PageRouteInfo route;
// }

sealed class QrCodeType {
  static const QrCodeType defaultQrCodeType = TextQrCodeType();

  factory QrCodeType.fromName(String name) {
    if (name == EpcQrCodeType.name) {
      return const EpcQrCodeType();
    } else {
      return const TextQrCodeType();
    }
  }

  PageRouteInfo get route;
  Feature? get feature;
}

final class TextQrCodeType implements QrCodeType {
  const TextQrCodeType();

  static const String name = 'text';

  @override
  PageRouteInfo get route => const TextQrCodeRoute();

  @override
  Feature? get feature => null;
}

final class EpcQrCodeType implements QrCodeType {
  const EpcQrCodeType();

  static const String name = 'epc';

  @override
  Feature? get feature => GetIt.I<EpcFeature>();

  @override
  PageRouteInfo get route => const EpcQrCodeRoute();
}

class CurrentQrCodeTypeNotifier extends ValueStream<QrCodeType> {
  CurrentQrCodeTypeNotifier() : super(const TextQrCodeType());
}

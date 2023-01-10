import 'package:auto_route/auto_route.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/state_management/value_stream.dart';

enum QrCodeType {
  text(TextQrCodeRoute()),
  epc(EpcQrCodeRoute());

  const QrCodeType(this.route);

  final PageRouteInfo route;
}

class CurrentQrCodeTypeNotifier extends ValueStream<QrCodeType> {
  CurrentQrCodeTypeNotifier() : super(QrCodeType.text);
}

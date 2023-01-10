import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLastUsedQrCodeType extends BehaviourWithoutInput<QrCodeType> {
  GetLastUsedQrCodeType({
    super.monitor,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  String get description => 'getting last used qr-code';

  @override
  Future<QrCodeType> action(BehaviourTrack? track) {
    return Future.value(
      sharedPreferences
              .getString(sharedPreferences.lastUsedQrCode)
              ?.toQrCodeType() ??
          QrCodeType.text,
    );
  }
}

extension _StringExtensions on String {
  QrCodeType toQrCodeType() {
    return QrCodeType.values
        .firstWhere((qrCodeType) => qrCodeType.name == this);
  }
}

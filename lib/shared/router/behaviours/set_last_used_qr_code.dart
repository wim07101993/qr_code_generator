import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetLastUsedQrCodeType extends Behaviour<QrCodeType, void> {
  SetLastUsedQrCodeType({
    super.monitor,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  String get description => 'setting last used qr-code';

  @override
  Future<void> action(QrCodeType input, BehaviourTrack? track) {
    return sharedPreferences.setString(
      sharedPreferences.lastUsedQrCode,
      switch (input) {
        TextQrCodeType() => TextQrCodeType.name,
        EpcQrCodeType() => EpcQrCodeType.name,
      },
    );
  }
}

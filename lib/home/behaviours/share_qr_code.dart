import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:share_plus/share_plus.dart';

class ShareQrCode extends Behaviour<ShareQrCodeParams, void> {
  ShareQrCode({
    super.monitor,
  });

  @override
  String get description => 'sharing qr-code';

  @override
  Future<void> action(ShareQrCodeParams input, BehaviourTrack? track) async {
    final data = await input.qrCode.toImageData(1024);
    if (data == null) {
      return;
    }
    await Share.shareXFiles(
      [
        XFile.fromData(
          data.buffer.asUint8List(),
          name: 'QR-code.png',
          mimeType: 'image/png',
        )
      ],
      text: input.translations.qrCode,
    );
  }
}

class ShareQrCodeParams {
  const ShareQrCodeParams({
    required this.qrCode,
    required this.translations,
  });

  final QrPainter qrCode;
  final AppLocalizations translations;
}

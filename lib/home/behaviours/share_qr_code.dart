import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/behaviours/get_local_image.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:share_plus/share_plus.dart';

class ShareQrCode extends Behaviour<ShareQrCodeParams, void> {
  ShareQrCode({
    super.monitor,
    required this.getLocalImage,
  });

  final GetLocalImage getLocalImage;

  @override
  String get description => 'sharing qr-code';

  @override
  Future<void> action(ShareQrCodeParams input, BehaviourTrack? track) async {
    final embeddedImageFilePath = input.styleSettings.embeddedImageFilePath;
    final embeddedImage = embeddedImageFilePath == null
        ? null
        : await getLocalImage(embeddedImageFilePath).thenWhen(
            (exception) => null,
            (value) => value,
          );

    final qrImage = await QrPainter(
      version: QrVersions.auto,
      data: input.qrData,
      dataModuleStyle: input.styleSettings.dataModuleStyle,
      eyeStyle: input.styleSettings.eyeStyle,
      gapless: input.styleSettings.gapless,
      embeddedImageStyle: input.styleSettings.embeddedImageStyle,
      embeddedImage: embeddedImage,
    ).toImageData(1024);
    if (qrImage == null) {
      return;
    }

    await Share.shareXFiles(
      [
        XFile.fromData(
          qrImage.buffer.asUint8List(),
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
    required this.qrData,
    required this.translations,
    required this.styleSettings,
  });

  final String qrData;
  final AppLocalizations translations;
  final StyleSettings styleSettings;
}

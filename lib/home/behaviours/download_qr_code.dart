import 'package:behaviour/behaviour.dart';
import 'package:download/download.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/behaviours/get_local_image.dart';

class DownloadQrCode extends Behaviour<DownloadQrCodeParams, void> {
  DownloadQrCode({
    super.monitor,
    required this.getLocalImage,
  });

  final GetLocalImage getLocalImage;

  @override
  String get description => 'downloading qr-code';

  @override
  Future<void> action(DownloadQrCodeParams input, BehaviourTrack? track) async {
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

    final stream = Stream.fromIterable(qrImage.buffer.asUint8List());
    download(stream, 'QR-code.png');
  }
}

class DownloadQrCodeParams {
  const DownloadQrCodeParams({
    required this.qrData,
    required this.styleSettings,
  });

  final String qrData;
  final StyleSettings styleSettings;
}

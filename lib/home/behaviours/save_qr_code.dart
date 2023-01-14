import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/behaviours/get_local_image.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class SaveQrCode extends Behaviour<SaveQrCodeParams, void> {
  SaveQrCode({
    super.monitor,
    required this.getLocalImage,
  });

  final GetLocalImage getLocalImage;

  @override
  String get description => 'saving qr-code';

  @override
  Future<void> action(SaveQrCodeParams input, BehaviourTrack? track) async {
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

    await File(input.outputPath).writeAsBytes(qrImage.buffer.asUint8List());
  }
}

class SaveQrCodeParams {
  const SaveQrCodeParams({
    required this.qrData,
    required this.translations,
    required this.styleSettings,
    required this.outputPath,
  });

  final String qrData;
  final AppLocalizations translations;
  final StyleSettings styleSettings;
  final String outputPath;
}

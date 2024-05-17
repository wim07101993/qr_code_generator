import 'dart:async';
import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class SaveQrCode extends Behaviour<SaveQrCodeParams, void> {
  SaveQrCode({
    super.monitor,
  });

  @override
  String get description => 'saving qr-code';

  @override
  FutureOr<void> action(SaveQrCodeParams input, BehaviourTrack? track) async {
    final qrImage = await input.qrCode.toImageData(1024);
    if (qrImage == null) {
      return;
    }
    await File(input.outputPath).writeAsBytes(qrImage.buffer.asUint8List());
  }
}

class SaveQrCodeParams {
  const SaveQrCodeParams({
    required this.qrCode,
    required this.translations,
    required this.outputPath,
  });

  final QrPainter qrCode;
  final AppLocalizations translations;
  final String outputPath;
}

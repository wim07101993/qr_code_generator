import 'package:behaviour/behaviour.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/behaviours/save_qr_code.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:share_plus/share_plus.dart';

class ShareQrCode extends Behaviour<ShareQrCodeParams, void> {
  ShareQrCode({
    super.monitor,
    required this.saveQrCode,
  });

  final SaveQrCode saveQrCode;

  @override
  String get description => throw UnimplementedError();

  @override
  Future<void> action(ShareQrCodeParams input, BehaviourTrack? track) async {
    final tempFilePath = await getTemporaryDirectory()
        .then((directory) => join(directory.path, 'qr-code.png'));

    await saveQrCode(
      SaveQrCodeParams(
        qrData: input.qrData,
        translations: input.translations,
        styleSettings: input.styleSettings,
        outputPath: tempFilePath,
      ),
    ).thenWhen(
      (exception) => throw exception,
      (value) => value,
    );

    await Share.shareXFiles(
      [XFile(tempFilePath)],
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

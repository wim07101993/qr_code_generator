import 'package:behaviour/behaviour.dart';
import 'package:download/download.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';

class DownloadQrCode extends Behaviour<QrPainter, void> {
  DownloadQrCode({
    super.monitor,
  });

  @override
  String get description => 'downloading qr-code';

  @override
  Future<void> action(QrPainter qrImage, BehaviourTrack? track) async {
    final data = await qrImage.toImageData(1024);
    if (data == null) {
      return;
    }
    final stream = Stream.fromIterable(data.buffer.asUint8List());
    download(stream, 'QR-code.png');
  }
}

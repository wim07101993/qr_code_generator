import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image_file_path.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetQrImage extends Behaviour<GetQrImageParams, QrPainter?> {
  GetQrImage({
    super.monitor,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  FutureOr<QrPainter?> action(
    GetQrImageParams input,
    BehaviourTrack? track,
  ) async {
    return QrPainter(
      version: QrVersions.auto,
      data: input.qrData,
      dataModuleStyle: input.styleSettings.dataModuleStyle,
      eyeStyle: input.styleSettings.eyeStyle,
      gapless: input.styleSettings.gapless,
      embeddedImageStyle: input.styleSettings.embeddedImageStyle,
      embeddedImage: await getImage(),
    );
  }

  Future<Image?> getImage() async {
    late final Uint8List? bytes;
    if (kIsWeb) {
      bytes = sharedPreferences.embeddedImageBytes;
    } else {
      final file = File(await getEmbeddedImageFilePath());
      if (await file.exists()) {
        bytes = await file.readAsBytes();
      } else {
        bytes = null;
      }
    }

    if (bytes == null) {
      return null;
    }

    final imageCompleter = Completer<Image?>();
    decodeImageFromList(bytes, (result) => imageCompleter.complete(result));
    return imageCompleter.future;
  }
}

class GetQrImageParams {
  const GetQrImageParams({
    required this.qrData,
    required this.styleSettings,
  });

  final String qrData;
  final StyleSettings styleSettings;
}

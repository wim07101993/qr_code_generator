import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getEmbeddedImageFilePath() async {
  final appsDir = await getApplicationDocumentsDirectory();
  final dir = Directory(join(appsDir.path, 'qr_code_generator'));
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
  return join(dir.path, 'qrImage');
}

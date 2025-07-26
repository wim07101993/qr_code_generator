import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image_file_path.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveEmbeddedImageFile extends Behaviour<Uint8List, void> {
  SaveEmbeddedImageFile({
    super.monitor,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> action(Uint8List bytes, BehaviourTrack? track) {
    return kIsWeb ? saveFileWeb(bytes) : saveFile(bytes);
  }

  Future<void> saveFile(Uint8List bytes) async {
    final file = File(await getEmbeddedImageFilePath());
    await file.writeAsBytes(bytes, mode: FileMode.writeOnly, flush: true);
  }

  Future<void> saveFileWeb(Uint8List bytes) {
    final base64Content = base64Encode(bytes);
    return sharedPreferences.setString(
      sharedPreferences.embeddedImageKey,
      base64Content,
    );
  }
}

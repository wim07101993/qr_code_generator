import 'dart:async';
import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image_file_path.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveEmbeddedImage extends BehaviourWithoutInput<void> {
  RemoveEmbeddedImage({
    super.monitor,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> action(BehaviourTrack? track) {
    return kIsWeb ? removeImageWeb() : removeImage();
  }

  Future<void> removeImage() async {
    final file = File(await getEmbeddedImageFilePath());
    await file.delete();
  }

  Future<void> removeImageWeb() {
    return sharedPreferences.remove(sharedPreferences.embeddedImageKey);
  }
}

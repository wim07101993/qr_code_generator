import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image_file_path.dart';
import 'package:qr_code_generator/shared/shared_preferences/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetEmbeddedImage extends BehaviourWithoutInput<ImageProvider?> {
  GetEmbeddedImage({
    super.monitor,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<ImageProvider?> action(BehaviourTrack? track) {
    return kIsWeb ? Future.value(sharedPreferences.embeddedImage) : getFile();
  }

  Future<ImageProvider?> getFile() async {
    final file = File(await getEmbeddedImageFilePath());
    return !await file.exists() ? null : FileImage(file);
  }
}

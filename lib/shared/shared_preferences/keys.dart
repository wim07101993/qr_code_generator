import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtensions on SharedPreferences {
  String get qrCodeStyleSettingsKey => 'qrCodeStyleData';
  String get epcDataKey => 'epcData';
  String get lastUsedQrCode => 'lastUsedQrCode';
  String get embeddedImageKey => 'embeddedImage';

  Uint8List? get embeddedImageBytes {
    final base64Content = getString(embeddedImageKey);
    if (base64Content == null) {
      return null;
    }
    return base64Decode(base64Content);
  }

  ImageProvider? get embeddedImage {
    final bytes = embeddedImageBytes;
    if (bytes == null) {
      return null;
    }
    return MemoryImage(bytes);
  }
}

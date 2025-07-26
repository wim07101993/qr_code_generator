import 'dart:async';
import 'dart:io';

import 'package:behaviour/behaviour.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class PickFile extends BehaviourWithoutInput<Uint8List?> {
  PickFile({
    super.monitor,
    required this.filePicker,
  });

  final FilePicker filePicker;

  @override
  Future<Uint8List?> action(BehaviourTrack? track) async {
    final fileResult = await filePicker.pickFiles();
    final file = fileResult?.files.singleOrNull;
    if (file == null) {
      return null;
    }
    return kIsWeb ? getFileBytesWeb(file) : getFileBytes(file);
  }

  FutureOr<Uint8List?> getFileBytes(PlatformFile file) {
    final path = file.path;
    return path == null ? null : File(path).readAsBytes();
  }

  FutureOr<Uint8List?> getFileBytesWeb(PlatformFile file) {
    return Future.value(file.bytes);
  }
}

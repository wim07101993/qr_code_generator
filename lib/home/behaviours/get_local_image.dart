import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:behaviour/behaviour.dart';

class GetLocalImage extends Behaviour<String, Image> {
  GetLocalImage({
    super.monitor,
  });

  @override
  String get description => 'getting local image';

  @override
  Future<Image> action(String input, BehaviourTrack? track) async {
    final file = File(input);
    if (!await file.exists()) {
      throw FileDoesNotExistsException(input);
    }

    final bytes = await file.readAsBytes();

    final imageCompleter = Completer<Image?>();
    decodeImageFromList(
      bytes,
      (result) => imageCompleter.complete(result),
    );
    final image = await imageCompleter.future;

    if (image == null) {
      throw CouldNotLoadImageException(input);
    }
    return image;
  }
}

class FileDoesNotExistsException implements Exception {
  const FileDoesNotExistsException(this.filePath);

  final String filePath;
}

class CouldNotLoadImageException implements Exception {
  const CouldNotLoadImageException(this.filePath);

  final String filePath;
}

import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image.dart';
import 'package:qr_code_generator/features/style/behaviours/pick_file.dart';
import 'package:qr_code_generator/features/style/behaviours/remove_embedded_image.dart';
import 'package:qr_code_generator/features/style/behaviours/save_embedded_image_file.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor({
    super.key,
    required this.image,
    required this.onImageChanged,
  });

  final ImageProvider? image;
  final ValueChanged<ImageProvider?> onImageChanged;

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  Future<void> _selectFile() async {
    final bytes = await GetIt.I<PickFile>()().thenWhen(
      (_) => null,
      (value) => value,
    );
    if (bytes == null) {
      return;
    }
    await GetIt.I<SaveEmbeddedImageFile>()(bytes);
    final newImage = await GetIt.I<GetEmbeddedImage>()()
        .thenWhen((_) => null, (image) => image);

    widget.onImageChanged(newImage);
  }

  Future<void> removeImageFile() async {
    GetIt.I<RemoveEmbeddedImage>()();
    widget.onImageChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final image = widget.image;
    return Row(
      children: [
        if (image != null) ...[
          Image(image: image, width: 40, height: 40),
          const SizedBox(width: 16),
          TextButton(
            onPressed: removeImageFile,
            child: Text(s.removeImageButtonLabel),
          ),
        ],
        TextButton(
          onPressed: () => _selectFile(),
          child: Text(s.selectImageFileButtonLabel),
        ),
      ],
    );
  }
}

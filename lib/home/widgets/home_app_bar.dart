import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_generator/app_router.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/epc/widgets/settings_sheet.dart';
import 'package:qr_code_generator/l10n/localization.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/widgets/listenable_builder.dart';
import 'package:qr_code_generator/style/notifiers/style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return ListenableBuilder(
      valueListenable: router,
      builder: (context) => AppBar(
        elevation: 0,
        actions: [
          _shareButton(context, router),
          _settingsButton(context, router),
        ].whereType<Widget>().toList(),
      ),
    );
  }

  Widget? _settingsButton(BuildContext context, StackRouter router) {
    final path = router.childControllers.first.current.path;
    VoidCallback? action;
    if (path == const EpcQrCodeRoute().path) {
      action = () => showModalBottomSheet(
            context: context,
            builder: (context) => const SettingsSheet(),
          );
    }
    if (action == null) {
      return null;
    }
    return IconButton(
      onPressed: action,
      icon: const Icon(Icons.settings),
    );
  }

  Widget? _shareButton(BuildContext context, StackRouter router) {
    final path = router.childControllers.first.current.path;
    VoidCallback? action;
    if (path == const EpcQrCodeRoute().path) {
      action =
          () => shareQrData(context, getIt<EpcDataNotifier>().value.qrData);
    }

    if (action == null) {
      return null;
    }
    return IconButton(
      onPressed: action,
      icon: Platform.isLinux ? const Icon(Icons.save) : const Icon(Icons.share),
    );
  }

  Future<void> shareQrData(BuildContext context, String qrData) async {
    final styleSettings = getIt<StyleSettingsNotifier>().value;
    final image = await QrPainter(
      version: QrVersions.auto,
      data: qrData,
      dataModuleStyle: styleSettings.dataModuleStyle,
      eyeStyle: styleSettings.eyeStyle,
      gapless: styleSettings.gapless,
      embeddedImageStyle: styleSettings.embeddedImageStyle,
      embeddedImage: await loadImage(styleSettings.embeddedImageFilePath),
    ).toImageData(1024);
    if (image == null || !mounted) {
      return;
    }

    final s = AppLocalizations.of(context)!;
    if (Platform.isLinux) {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: s.saveQrDialogTitle,
        fileName: 'qr-code.png',
      );
      if (result != null) {
        await File(result).writeAsBytes(image.buffer.asUint8List());
      }
    } else {
      final file = await getTemporaryDirectory()
          .then((directory) => join(directory.path, 'qr-code.png'))
          .then((path) => File(path))
          .then((file) => file.writeAsBytes(image.buffer.asInt8List()));
      await Share.shareXFiles([XFile(file.path)], text: s.qrCode);
    }
  }

  Future<ui.Image?> loadImage(String? path) async {
    try {
      if (path == null) {
        return null;
      }
      final file = File(path);
      if (!await file.exists()) {
        return null;
      }

      final bytes = await file.readAsBytes();

      final imageCompleter = Completer<ui.Image?>();
      ui.decodeImageFromList(
        bytes,
        (result) => imageCompleter.complete(result),
      );
      return imageCompleter.future;
    } catch (e) {
      return null;
    }
  }
}

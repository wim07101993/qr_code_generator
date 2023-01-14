import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/behaviours/save_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/share_qr_code.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/l10n/behaviour_extensions.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.canShareQrCode,
    required this.canSaveQrCode,
    required this.settingsAction,
  });

  final bool canShareQrCode;
  final bool canSaveQrCode;
  final VoidCallback? settingsAction;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  Future<void> shareQrData(BuildContext context) {
    return getIt<ShareQrCode>()(
      ShareQrCodeParams(
        qrData: getIt<EpcDataNotifier>().value.qrData,
        translations: AppLocalizations.of(context)!,
        styleSettings: getIt<StyleSettingsNotifier>().value,
      ),
    ).handleException(context, isMounted: () => mounted);
  }

  Future<void> saveQrCode(BuildContext context) async {
    final s = AppLocalizations.of(context)!;
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: s.saveQrDialogTitle,
      fileName: 'qr-code.png',
    );
    if (outputPath == null || !mounted) {
      return;
    }
    return getIt<SaveQrCode>()(
      SaveQrCodeParams(
        qrData: getIt<EpcDataNotifier>().value.qrData,
        translations: s,
        styleSettings: getIt<StyleSettingsNotifier>().value,
        outputPath: outputPath,
      ),
    ).handleException(context, isMounted: () => mounted);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        if (widget.canShareQrCode)
          IconButton(
            onPressed: () => shareQrData(context),
            icon: const Icon(Icons.share),
          ),
        if (widget.canSaveQrCode)
          IconButton(
            onPressed: () => shareQrData(context),
            icon: const Icon(Icons.save),
          ),
        if (widget.settingsAction != null)
          IconButton(
            onPressed: widget.settingsAction,
            icon: const Icon(Icons.settings),
          ),
      ].whereType<Widget>().toList(),
    );
  }
}

import 'dart:async';

import 'package:behaviour/behaviour.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/behaviours/download_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/get_qr_image.dart';
import 'package:qr_code_generator/home/behaviours/save_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/share_qr_code.dart';
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
  Future<void> getQrCode(
    BuildContext context,
    Future<ExceptionOr<dynamic>> Function(QrPainter qrCode) sendToUser,
  ) {
    return GetIt.I<GetQrImage>()(
      GetQrImageParams(
        qrData: GetIt.I<EpcDataNotifier>().value.qrData,
        styleSettings: GetIt.I<StyleSettingsNotifier>().value,
      ),
    ).thenStartNextWhenSuccess((qrCode) {
      if (qrCode == null || !mounted) {
        return Future.value(const Success(null));
      }
      return sendToUser(qrCode);
    }).handleException(context, isMounted: () => mounted);
  }

  Future<void> shareQrData(BuildContext context) {
    return getQrCode(
      context,
      (qrCode) => GetIt.I<ShareQrCode>()(
        ShareQrCodeParams(
          qrCode: qrCode,
          translations: AppLocalizations.of(context)!,
        ),
      ),
    );
  }

  Future<void> saveQrCode(BuildContext context) async {
    final s = AppLocalizations.of(context)!;
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: s.saveQrDialogTitle,
      fileName: 'qr-code.png',
    );

    if (!mounted) return;
    if (outputPath == null) return;

    return getQrCode(
      context,
      (qrCode) => GetIt.I<SaveQrCode>()(
        SaveQrCodeParams(
          translations: s,
          outputPath: outputPath,
          qrCode: qrCode,
        ),
      ),
    );
  }

  Future<void> downloadQrCode() {
    return getQrCode(context, (qrCode) => GetIt.I<DownloadQrCode>()(qrCode));
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
            onPressed: () => kIsWeb ? downloadQrCode() : saveQrCode(context),
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

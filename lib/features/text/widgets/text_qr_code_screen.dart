import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/qr_data_controller.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/widgets/qr_code_screen.dart';

@RoutePage()
class TextQrCodeScreen extends StatefulWidget {
  const TextQrCodeScreen({super.key});

  @override
  State<TextQrCodeScreen> createState() => _TextQrCodeScreenState();
}

class _TextQrCodeScreenState extends State<TextQrCodeScreen> {
  final controller = TextEditingController();
  late final qrDataNotifier = QrDataController(
    listenable: controller,
    valueGetter: () => controller.text,
  );

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return QrCodeScreen(
      inputBuilder: (context) => TextField(
        controller: controller,
        maxLines: null,
        maxLength: QrDataController.maxLength,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          helperText: s.textInputHelperText,
        ),
      ),
      qrData: qrDataNotifier,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/state_management/forwarding_notifier.dart';
import 'package:qr_code_generator/shared/widgets/qr_code_screen.dart';

class TextQrCodeScreen extends StatefulWidget {
  const TextQrCodeScreen({super.key});

  @override
  State<TextQrCodeScreen> createState() => _TextQrCodeScreenState();
}

class _TextQrCodeScreenState extends State<TextQrCodeScreen> {
  final controller = TextEditingController();
  late final qrDataNotifier = ForwardingNotifier<String>(
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
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          helperText: s.textInputHelperText,
        ),
      ),
      qrData: qrDataNotifier,
    );
  }
}

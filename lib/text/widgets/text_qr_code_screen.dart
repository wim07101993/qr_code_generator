import 'package:flutter/material.dart';
import 'package:qr_code_generator/shared/notifier/forwarding_notifier.dart';
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
    return QrCodeScreen(
      inputBuilder: (context) => TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
      qrData: qrDataNotifier,
    );
  }
}

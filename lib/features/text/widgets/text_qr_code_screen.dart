import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/state_management/forwarding_notifier.dart';
import 'package:qr_code_generator/shared/widgets/qr_code_screen.dart';

@RoutePage()
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
  void initState() {
    getIt<CurrentQrCodeTypeNotifier>().value = QrCodeType.text;
    super.initState();
  }

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

import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/notifier/forwarding_notifier.dart';
import 'package:qr_code_generator/shared/widgets/qr_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EpcQrCodeScreen extends StatefulWidget {
  const EpcQrCodeScreen({super.key});

  @override
  State<EpcQrCodeScreen> createState() => _EpcQrCodeScreenState();
}

class _EpcQrCodeScreenState extends State<EpcQrCodeScreen> {
  final formKey = GlobalKey<FormState>();
  final SharedPreferences sharedPreferences = getIt();
  final EpcDataNotifier epcDataNotifier = getIt();
  late final qrDataNotifier = ForwardingNotifier<String>(
    listenable: epcDataNotifier,
    valueGetter: () => (epcDataNotifier.value ?? lastValidEpcData).qrData,
  );

  late EpcData lastValidEpcData;

  String? get amountErrorMessage =>
      EpcData.validateAmount(epcDataNotifier.amount.text);

  @override
  void initState() {
    lastValidEpcData = epcDataNotifier.value ??
        sharedPreferences.loadEpcData() ??
        EpcData.defaultValue();
    super.initState();
  }

  @override
  void dispose() {
    qrDataNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QrCodeScreen(
      qrData: qrDataNotifier,
      inputBuilder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('€', style: TextStyle(fontSize: 35)),
            Expanded(
              child: TextField(
                controller: epcDataNotifier.amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: amountErrorMessage,
                ),
                style: const TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

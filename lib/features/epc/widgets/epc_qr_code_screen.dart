import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/function_tree_extensions.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/state_management/forwarding_notifier.dart';
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
    valueGetter: () => (epcDataNotifier.value).qrData,
  );

  late EpcData lastValidEpcData;

  String? get amountErrorMessage =>
      EpcData.validateAmount(epcDataNotifier.amount.text.tryInterpret());

  void amountChanged() => setState(() {});

  @override
  void initState() {
    getIt<CurrentQrCodeTypeNotifier>().value = QrCodeType.epc;
    lastValidEpcData = epcDataNotifier.value;
    epcDataNotifier.amount.addListener(amountChanged);
    super.initState();
  }

  @override
  void dispose() {
    epcDataNotifier.amount.removeListener(amountChanged);
    qrDataNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QrCodeScreen(
      qrData: qrDataNotifier,
      inputBuilder: (context) {
        final amountText = epcDataNotifier.amount.text.trim();
        final amountValue = epcDataNotifier.value.amount.toString();
        return TextField(
          controller: epcDataNotifier.amount,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: amountErrorMessage,
            errorMaxLines: 3,
            prefixIcon: const Icon(Icons.euro),
            suffix: amountText != amountValue ? Text(amountValue) : null,
          ),
          style: const TextStyle(fontSize: 35),
        );
      },
    );
  }
}

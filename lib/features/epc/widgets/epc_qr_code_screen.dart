import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/epc/widgets/value_text_field.dart';
import 'package:qr_code_generator/qr_data_controller.dart';
import 'package:qr_code_generator/shared/widgets/qr_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class EpcQrCodeScreen extends StatefulWidget {
  const EpcQrCodeScreen({super.key});

  @override
  State<EpcQrCodeScreen> createState() => _EpcQrCodeScreenState();
}

class _EpcQrCodeScreenState extends State<EpcQrCodeScreen> {
  final formKey = GlobalKey<FormState>();
  final SharedPreferences sharedPreferences = GetIt.I();
  final EpcDataNotifier epcDataNotifier = GetIt.I();
  final QrDataController qrDataController = GetIt.I();

  late EpcData lastValidEpcData;

  String? get amountErrorMessage {
    return EpcData.validateAmountInCents(
      epcDataNotifier.amount.text.tryConvertToAmountInCents(),
    );
  }

  void amountChanged() {
    // setState(() {});
    qrDataController.value = epcDataNotifier.value.qrData;
  }

  @override
  void initState() {
    lastValidEpcData = epcDataNotifier.value;
    epcDataNotifier.amount.addListener(amountChanged);
    super.initState();
  }

  @override
  void dispose() {
    epcDataNotifier.amount.removeListener(amountChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QrCodeScreen(
      qrData: qrDataController,
      inputBuilder: (context) => ValueTextField(
        controller: epcDataNotifier.amount,
        amountValueInCents: epcDataNotifier.value.amountInCents,
        errorMessage: amountErrorMessage,
      ),
    );
  }
}

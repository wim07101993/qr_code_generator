import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/style/notifiers/style_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
  late EpcData lastValidEpcData;

  String? get amountErrorMessage =>
      EpcData.validateAmount(epcDataNotifier.amount.text);

  @override
  void initState() {
    lastValidEpcData = epcDataNotifier.value ??
        sharedPreferences.loadEpcData() ??
        EpcData.defaultValue();
    epcDataNotifier.addListener(epcDataChanged);
    super.initState();
  }

  @override
  void dispose() {
    epcDataNotifier.removeListener(epcDataChanged);
    super.dispose();
  }

  void epcDataChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, styleSettings, _) => Column(
        children: [
          _amount(context),
          const SizedBox(height: 8),
          Expanded(child: _qrCode(styleSettings)),
        ],
      ),
    );
  }

  Widget _amount(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _qrCode(StyleSettings settings) {
    return QrImage(
      data: (epcDataNotifier.value ?? lastValidEpcData).qrData,
      dataModuleStyle: settings.dataModuleStyle,
      embeddedImage: settings.embeddedImage,
      embeddedImageStyle: settings.embeddedImageStyle,
      eyeStyle: settings.eyeStyle,
      gapless: settings.gapless,
    );
  }
}

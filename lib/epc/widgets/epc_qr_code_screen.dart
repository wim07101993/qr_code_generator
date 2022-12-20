import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/app_router.dart';
import 'package:qr_code_generator/epc/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/epc/widgets/settings_sheet.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/qr_code_style/notifiers/qr_code_style_settings.dart';
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
    final theme = Theme.of(context);
    return ValueListenableBuilder<QrCodeStyleSettings>(
      valueListenable: getIt<QrCodeStyleSettingsNotifier>(),
      builder: (context, styleSettings, _) => Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                _qrCodeStyleItem(context, theme),
                _aboutItem(context),
              ],
            ),
          ],
        ),
        backgroundColor: styleSettings.backgroundColor.withAlpha(255),
        body: SafeArea(
          child: Column(
            children: [
              _amountForm(context),
              Expanded(child: Center(child: _qrCode(styleSettings))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: epcDataNotifier.amount,
                validator: EpcData.validateAmount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Amount')),
              ),
            ),
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => const SettingsSheet(),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qrCode(QrCodeStyleSettings settings) {
    return QrImage(
      data: (epcDataNotifier.value ?? lastValidEpcData).qrData,
      dataModuleStyle: settings.dataModuleStyle,
      embeddedImage: settings.embeddedImage,
      embeddedImageStyle: settings.embeddedImageStyle,
      eyeStyle: settings.eyeStyle,
      gapless: settings.gapless,
    );
  }

  PopupMenuItem _qrCodeStyleItem(BuildContext context, ThemeData theme) {
    return PopupMenuItem(
      onTap: () => AutoRouter.of(context).push(const QrCodeStyleRoute()),
      child: Row(
        children: [
          Icon(
            Icons.style,
            color: theme.textTheme.bodyText2?.color,
          ),
          const Text('QR-code style'),
        ],
      ),
    );
  }

  PopupMenuItem _aboutItem(BuildContext context) {
    return PopupMenuItem(
      onTap: () => showAboutDialog(
        context: context,
        applicationName: 'QR-code generator',
      ),
      child: const Text('About'),
    );
  }
}

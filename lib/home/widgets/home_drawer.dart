import 'package:flutter/material.dart';
import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/router/notifier/is_updating_style_notifier.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(s.textQrDrawerOption),
            onTap: () => loadQrCodeFeature(context, const TextQrCodeType()),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(s.epcPaymentDrawerOption),
            onTap: () => loadQrCodeFeature(context, const EpcQrCodeType()),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(s.qrCodeStyleDrawerOption),
            onTap: () {
              GetIt.I<IsUpdatingStyleNotifier>().value = true;
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(s.aboutDrawerOption),
            onTap: () => showAboutDialog(context: context),
          ),
        ],
      ),
    );
  }

  Future<void> loadQrCodeFeature(
    BuildContext context,
    QrCodeType qrCodeType,
  ) async {
    await qrCodeType.feature?.ensureInstalled();
    GetIt.I<CurrentQrCodeTypeNotifier>().value = qrCodeType;
    GetIt.I<IsUpdatingStyleNotifier>().value = false;
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  void loadStyle(BuildContext context) {}
}

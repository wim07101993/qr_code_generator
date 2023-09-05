import 'package:flutter/material.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/router/notifier/is_updating_style_notifier.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(s.textQrDrawerOption),
            onTap: () {
              getIt<CurrentQrCodeTypeNotifier>().value = QrCodeType.text;
              getIt<IsUpdatingStyleNotifier>().value = false;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(s.epcPaymentDrawerOption),
            onTap: () {
              getIt<CurrentQrCodeTypeNotifier>().value = QrCodeType.epc;
              getIt<IsUpdatingStyleNotifier>().value = false;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(s.qrCodeStyleDrawerOption),
            onTap: () {
              getIt<IsUpdatingStyleNotifier>().value = true;
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
}

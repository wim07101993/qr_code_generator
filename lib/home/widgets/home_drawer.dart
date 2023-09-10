import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
              GetIt.I<CurrentQrCodeTypeNotifier>().value = QrCodeType.text;
              GetIt.I<IsUpdatingStyleNotifier>().value = false;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(s.epcPaymentDrawerOption),
            onTap: () {
              GetIt.I<CurrentQrCodeTypeNotifier>().value = QrCodeType.epc;
              GetIt.I<IsUpdatingStyleNotifier>().value = false;
              Navigator.pop(context);
            },
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
}

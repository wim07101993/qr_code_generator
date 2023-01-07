import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';

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
            onTap: () => context.replaceRoute(const TextQrCodeRoute()),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(s.epcPaymentDrawerOption),
            onTap: () => context.replaceRoute(const EpcQrCodeRoute()),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(s.qrCodeStyleDrawerOption),
            onTap: () => context.replaceRoute(const StyleRoute()),
          ),
          ListTile(
            title: Text(s.aboutDrawerOption),
            onTap: () => showAboutDialog(context: context),
          )
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/app_router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('EPC QR-code'),
            onTap: () => context.replaceRoute(const EpcQrCodeRoute()),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('QR-code style'),
            onTap: () => context.replaceRoute(const StyleRoute()),
          ),
          ListTile(
            title: const Text('About'),
            onTap: () => showAboutDialog(context: context),
          )
        ],
      ),
    );
  }
}

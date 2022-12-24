import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/app_router.dart';
import 'package:qr_code_generator/epc/widgets/settings_sheet.dart';
import 'package:qr_code_generator/shared/widgets/listenable_builder.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    // final iconTheme = IconThemeData(
    //   color: styleSettings.dataModuleStyle.color,
    //   size: 32,
    // );
    return ListenableBuilder(
      valueListenable: router,
      builder: (context) {
        final childController = router.childControllers.first;
        final routerPath = childController.current.path;
        return AppBar(
          // iconTheme: iconTheme,
          // backgroundColor: styleSettings.backgroundColor,
          elevation: 0,
          // actionsIconTheme: iconTheme,
          actions: [
            if (routerPath == const EpcQrCodeRoute().path)
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const SettingsSheet(),
                ),
                icon: const Icon(Icons.settings),
              ),
          ],
        );
      },
    );
  }
}

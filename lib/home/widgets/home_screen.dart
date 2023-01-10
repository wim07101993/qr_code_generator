import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/widgets/home_app_bar.dart';
import 'package:qr_code_generator/home/widgets/home_drawer.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/router/notifier/is_updating_style_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, styleSettings, _) => Scaffold(
        backgroundColor: styleSettings.backgroundColor.withAlpha(255),
        drawer: const HomeDrawer(),
        appBar: const HomeAppBar(),
        body: ValueListenableBuilder(
          valueListenable: getIt<IsUpdatingStyleNotifier>(),
          builder: (context, isUpdatingStyle, _) {
            return ValueListenableBuilder(
              valueListenable: getIt<CurrentQrCodeTypeNotifier>(),
              builder: (context, currentQrCodeType, _) {
                return AutoRouter.declarative(
                  routes: (_) => [
                    currentQrCodeType.route,
                    if (isUpdatingStyle) const StyleRoute(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

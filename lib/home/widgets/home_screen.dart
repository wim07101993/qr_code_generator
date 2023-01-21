import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/widgets/settings_sheet.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/notifiers/navigation_notifier.dart';
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
  bool _canShareQrCode(bool isUpdatingStyle) {
    return !isUpdatingStyle &&
        !kIsWeb &&
        (Platform.isAndroid || Platform.isIOS || Platform.isWindows);
  }

  bool _canSaveQrCode(bool isUpdatingStyle) {
    return !isUpdatingStyle &&
        (kIsWeb || Platform.isLinux || Platform.isWindows);
  }

  VoidCallback? _settingsAction(
    bool isUpdatingStyle,
    QrCodeType currentQrCodeType,
  ) {
    if (isUpdatingStyle) {
      return null;
    }
    switch (currentQrCodeType) {
      case QrCodeType.text:
        return null;
      case QrCodeType.epc:
        return showEpcSettings;
    }
  }

  void showEpcSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SettingsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, styleSettings, _) => ValueListenableBuilder(
        valueListenable: getIt<IsUpdatingStyleNotifier>(),
        builder: (context, isUpdatingStyle, _) => ValueListenableBuilder(
          valueListenable: getIt<CurrentQrCodeTypeNotifier>(),
          builder: (context, currentQrCodeType, _) => Scaffold(
            backgroundColor: styleSettings.backgroundColor.withAlpha(255),
            drawer: const HomeDrawer(),
            appBar: HomeAppBar(
              canShareQrCode: _canShareQrCode(isUpdatingStyle),
              canSaveQrCode: _canSaveQrCode(isUpdatingStyle),
              settingsAction: _settingsAction(
                isUpdatingStyle,
                currentQrCodeType,
              ),
            ),
            body: AutoRouter.declarative(
              onNavigate: getIt<NavigationNotifier>().onNavigate,
              routes: (_) => [
                currentQrCodeType.route,
                if (isUpdatingStyle) const StyleRoute(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

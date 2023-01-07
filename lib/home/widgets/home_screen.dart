import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/home/widgets/home_app_bar.dart';
import 'package:qr_code_generator/home/widgets/home_drawer.dart';
import 'package:qr_code_generator/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
      builder: (context, styleSettings, _) => Scaffold(
        backgroundColor: styleSettings.backgroundColor.withAlpha(255),
        drawer: const HomeDrawer(),
        appBar: const HomeAppBar(),
        body: const AutoRouter(),
      ),
    );
  }
}

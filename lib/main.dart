import 'package:auto_route/auto_route.dart';
import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/features/epc/epc_feature.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/features/style/qr_code_style_feature.dart';
import 'package:qr_code_generator/home/installer.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/logging/logging_feature.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/router/routing_feature.dart';
import 'package:qr_code_generator/shared/shared_preferences/shared_preferences_feature.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final featureManager = FeatureManager(
    features: [
      const LoggingFeature(),
      const SharedPreferencesFeature(),
      RoutingFeature(),
      const EpcFeature(),
      const QrCodeStyleFeature(),
      const HomeFeature(),
    ],
  )..registerTypes();
  await featureManager.install();

  final router = GetIt.I<AppRouter>();
  runApp(
    ValueListenableBuilder<StyleSettings>(
      valueListenable: GetIt.I<StyleSettingsNotifier>(),
      builder: (context, settings, _) => MaterialApp.router(
        title: 'QR-code generator',
        theme: settings.toThemeData(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('nl'),
        ],
        routerDelegate: router.delegate(
          deepLinkBuilder: (deeplink) => const DeepLink([HomeRoute()]),
        ),
        routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

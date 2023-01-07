import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_code_generator/features/epc/installer.dart';
import 'package:qr_code_generator/features/style/installer.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/get_it/get_it_extensions.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/router/installer.dart';
import 'package:qr_code_generator/shared/shared_preferences_installer.dart';

final getIt = GetIt.asNewInstance();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<List<Installer>>([
    SharedPreferencesInstaller(),
    RouterInstaller(),
    EpcInstaller(),
    QrCodeStyleInstaller(),
  ]);
  getIt.registerDependenciesOfInstallers();
  await getIt.installInstallers();

  final router = getIt<AppRouter>();
  runApp(
    ValueListenableBuilder<StyleSettings>(
      valueListenable: getIt<StyleSettingsNotifier>(),
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
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

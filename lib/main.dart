import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/app_router.dart';
import 'package:qr_code_generator/epc/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/l10n/localization.dart';
import 'package:qr_code_generator/style/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/style/notifiers/style_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.asNewInstance();
AppRouter router = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);

  getIt.registerLazySingleton(
    () => EpcDataNotifier()
      ..value = getIt<SharedPreferences>().loadEpcData()
      ..addListener(saveEpcData),
    dispose: (notifier) => notifier.dispose(),
  );

  getIt.registerLazySingleton(
    () => StyleSettingsNotifier()
      ..value =
          getIt<SharedPreferences>().loadStyleSettings() ?? StyleSettings()
      ..addListener(saveStyleSettings),
    dispose: (notifier) => notifier.dispose(),
  );

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

Future<void> saveEpcData() {
  return getIt<SharedPreferences>().saveEpcData(
    getIt<EpcDataNotifier>().value,
  );
}

Future<void> saveStyleSettings() {
  return getIt<SharedPreferences>().saveStyleSettings(
    getIt<StyleSettingsNotifier>().value,
  );
}

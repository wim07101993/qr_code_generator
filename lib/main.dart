import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/app_router.dart';
import 'package:qr_code_generator/epc/data/shared_preferences_extensions.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/qr_code_style/notifiers/qr_code_style_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.asNewInstance();
AppRouter router = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);
  getIt.registerLazySingleton(
    () {
      final notifier = EpcDataNotifier();
      final epcData = getIt<SharedPreferences>().loadEpcData();
      if (epcData != null) {
        notifier.loadEpcData(epcData);
      }
      return notifier;
    },
    dispose: (notifier) => notifier.dispose(),
  );
  getIt.registerLazySingleton(() {
    final notifier = QrCodeStyleSettingsNotifier();
    // final settings = getIt<SharedPreferences>().
    // TODO load
    return notifier;
  }, dispose: (notifier) => notifier.dispose());

  runApp(
    MaterialApp.router(
      title: 'QR-code generator',
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

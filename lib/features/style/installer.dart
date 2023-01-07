import 'package:qr_code_generator/features/style/behaviours/load_style_settings.dart';
import 'package:qr_code_generator/features/style/behaviours/save_style_settings.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';

class QrCodeStyleInstaller extends Installer {
  late final GetIt getIt;

  @override
  void registerDependenciesInternal(GetIt getIt) {
    this.getIt = getIt;
    getIt.registerLazySingleton(
      () => StyleSettingsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );

    getIt.registerFactoryAsync(
      () async => LoadStyleSettings(
        monitor: getIt(),
        sharedPreferences: await getIt.getAsync(),
        styleSettingsNotifier: getIt(),
      ),
    );
    getIt.registerFactory(
      () => SaveStyleSettings(
        monitor: getIt(),
        sharedPreferences: getIt(),
        styleSettingsNotifier: getIt(),
      ),
    );
  }

  @override
  Future<void> installInternal(GetIt getIt) async {
    await getIt
        .getAsync<LoadStyleSettings>()
        .then((loadStyleSettings) => loadStyleSettings());
    getIt<StyleSettingsNotifier>().addListener(onEpcDataChanged);
  }

  @override
  void dispose() {
    getIt<StyleSettingsNotifier>().removeListener(onEpcDataChanged);
    super.dispose();
  }

  void onEpcDataChanged() {
    getIt<SaveStyleSettings>()();
  }
}

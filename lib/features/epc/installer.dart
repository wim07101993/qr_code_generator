import 'package:qr_code_generator/features/epc/behaviours/load_epc_data.dart';
import 'package:qr_code_generator/features/epc/behaviours/save_epc_data.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';

class EpcInstaller extends Installer {
  late final GetIt getIt;

  @override
  void registerDependenciesInternal(GetIt getIt) {
    this.getIt = getIt;
    getIt.registerLazySingleton(
      () => EpcDataNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );

    getIt.registerFactoryAsync(
      () async => LoadEpcData(
        sharedPreferences: await getIt.getAsync(),
        epcDataNotifier: getIt(),
      ),
    );
    getIt.registerFactory(
      () => SaveEpcData(
        sharedPreferences: getIt(),
        epcDataNotifier: getIt(),
      ),
    );
  }

  @override
  Future<void> installInternal(GetIt getIt) async {
    await getIt.getAsync<LoadEpcData>().then((loadEpcData) => loadEpcData());
    getIt<EpcDataNotifier>().addListener(onEpcDataChanged);
  }

  @override
  void dispose() {
    getIt<EpcDataNotifier>().removeListener(onEpcDataChanged);
    super.dispose();
  }

  void onEpcDataChanged() => getIt<SaveEpcData>()();
}

import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:qr_code_generator/features/epc/behaviours/load_epc_data.dart';
import 'package:qr_code_generator/features/epc/behaviours/save_epc_data.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';

class EpcFeature extends Feature {
  const EpcFeature();

  @override
  void registerTypes() {
    getIt.registerLazySingleton(
      () => EpcDataNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );

    getIt.registerFactoryAsync(
      () async => LoadEpcData(
        monitor: getIt(),
        sharedPreferences: await getIt.getAsync(),
        epcDataNotifier: getIt(),
      ),
    );
    getIt.registerFactory(
      () => SaveEpcData(
        monitor: getIt(),
        sharedPreferences: getIt(),
        epcDataNotifier: getIt(),
      ),
    );
  }

  @override
  Future<void> install() async {
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

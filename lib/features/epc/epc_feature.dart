import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/features/epc/behaviours/load_epc_data.dart';
import 'package:qr_code_generator/features/epc/behaviours/save_epc_data.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/style/qr_code_style_feature.dart';

class EpcFeature extends Feature {
  const EpcFeature();

  @override
  Iterable<Feature> get dependencies => [GetIt.I<QrCodeStyleFeature>()];

  @override
  void registerTypes() {
    GetIt.I.registerLazySingleton(
      () => EpcDataNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );

    GetIt.I.registerFactoryAsync(
      () async => LoadEpcData(
        monitor: GetIt.I(),
        sharedPreferences: await GetIt.I.getAsync(),
        epcDataNotifier: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => SaveEpcData(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
        epcDataNotifier: GetIt.I(),
      ),
    );
  }

  @override
  Future<void> install() async {
    await GetIt.I.getAsync<LoadEpcData>().then((loadEpcData) => loadEpcData());
    GetIt.I<EpcDataNotifier>().addListener(onEpcDataChanged);
  }

  @override
  void dispose() {
    GetIt.I<EpcDataNotifier>().removeListener(onEpcDataChanged);
    super.dispose();
  }

  void onEpcDataChanged() => GetIt.I<SaveEpcData>()();
}

import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/home/behaviours/download_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/get_qr_image.dart';
import 'package:qr_code_generator/home/behaviours/save_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/share_qr_code.dart';
import 'package:qr_code_generator/home/notifiers/navigation_notifier.dart';
import 'package:qr_code_generator/shared/shared_preferences/shared_preferences_feature.dart';

class HomeFeature extends Feature {
  const HomeFeature();

  @override
  Iterable<Feature> get dependencies => [GetIt.I<SharedPreferencesFeature>()];

  @override
  void registerTypes() {
    GetIt.I.registerFactory(
      () => GetQrImage(monitor: GetIt.I(), sharedPreferences: GetIt.I()),
    );
    GetIt.I.registerFactory(() => DownloadQrCode(monitor: GetIt.I()));
    GetIt.I.registerFactory(() => SaveQrCode(monitor: GetIt.I()));
    GetIt.I.registerFactory(() => ShareQrCode(monitor: GetIt.I()));
    GetIt.I.registerLazySingleton(() => NavigationNotifier());
  }
}

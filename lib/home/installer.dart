import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:qr_code_generator/home/behaviours/download_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/get_qr_image.dart';
import 'package:qr_code_generator/home/behaviours/save_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/share_qr_code.dart';
import 'package:qr_code_generator/home/notifiers/navigation_notifier.dart';
import 'package:qr_code_generator/shared/shared_preferences/shared_preferences_feature.dart';

class HomeFeature extends Feature {
  const HomeFeature();

  @override
  List<Type> get dependencies => [SharedPreferencesFeature];

  @override
  void registerTypes() {
    getIt.registerFactory(
      () => GetQrImage(monitor: getIt(), sharedPreferences: getIt()),
    );
    getIt.registerFactory(() => DownloadQrCode(monitor: getIt()));
    getIt.registerFactory(() => SaveQrCode(monitor: getIt()));
    getIt.registerFactory(() => ShareQrCode(monitor: getIt()));
    getIt.registerLazySingleton(() => NavigationNotifier());
  }
}

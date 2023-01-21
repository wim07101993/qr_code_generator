import 'package:qr_code_generator/home/behaviours/download_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/get_local_image.dart';
import 'package:qr_code_generator/home/behaviours/save_qr_code.dart';
import 'package:qr_code_generator/home/behaviours/share_qr_code.dart';
import 'package:qr_code_generator/home/notifiers/navigation_notifier.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';

class HomeInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerFactory(() => GetLocalImage(monitor: getIt()));
    getIt.registerFactory(
      () => DownloadQrCode(monitor: getIt(), getLocalImage: getIt()),
    );
    getIt.registerFactory(
      () => SaveQrCode(monitor: getIt(), getLocalImage: getIt()),
    );
    getIt.registerFactory(
      () => ShareQrCode(monitor: getIt(), getLocalImage: getIt()),
    );
    getIt.registerLazySingleton(() => NavigationNotifier());
  }
}

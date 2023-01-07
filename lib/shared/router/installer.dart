import 'package:qr_code_generator/shared/get_it/installer.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';

class RouterInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(() => AppRouter());
  }
}

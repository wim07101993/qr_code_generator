import 'package:qr_code_generator/shared/get_it/installer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingletonAsync(() => SharedPreferences.getInstance());
  }
}

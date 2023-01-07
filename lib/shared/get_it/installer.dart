import 'package:get_it/get_it.dart';

export 'package:get_it/get_it.dart';

abstract class Installer {
  bool _isInstalled = false;

  int get priority => 100;
  bool get isInstalled => _isInstalled;

  void registerDependencies(GetIt getIt) {
    registerDependenciesInternal(getIt);
  }

  void registerDependenciesInternal(GetIt getIt);

  Future<void> install(GetIt getIt) async {
    _isInstalled = true;
  }

  Future<void> installInternal(GetIt getIt) => Future.value();

  void dispose() {}
}

import 'package:flutter/foundation.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/shared/get_it/get_it_extensions.dart';

export 'package:get_it/get_it.dart';

abstract class Installer {
  bool _isInstalled = false;
  bool _isRegistered = false;

  bool isLoggingEnabled = true;

  int get priority => 100;
  bool get isInstalled => _isInstalled;
  bool get hasRegisteredDependencies => _isRegistered;

  @mustCallSuper
  void registerDependencies(GetIt getIt) {
    if (isLoggingEnabled) {
      getIt.logger(runtimeType.toString()).v('registering dependencies');
    }
    registerDependenciesInternal(getIt);
    _isRegistered = true;
    if (isLoggingEnabled) {
      getIt.logger(runtimeType.toString()).i('registered dependencies');
    }
  }

  void registerDependenciesInternal(GetIt getIt);

  @mustCallSuper
  Future<void> install(GetIt getIt) async {
    if (isLoggingEnabled) {
      getIt.logger(runtimeType.toString()).v('installing');
    }
    await installInternal(getIt);
    _isInstalled = true;
    if (isLoggingEnabled) {
      getIt.logger(runtimeType.toString()).i('installed');
    }
  }

  Future<void> installInternal(GetIt getIt) => Future.value();

  void dispose() {}
}

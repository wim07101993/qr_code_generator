import 'dart:async';

import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/router/behaviours/get_last_used_qr_code.dart';
import 'package:qr_code_generator/shared/router/behaviours/set_last_used_qr_code.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/router/notifier/is_updating_style_notifier.dart';

class RouterInstaller extends Installer {
  StreamSubscription? qrCodeTypeChangeSubscription;

  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerFactory(
      () => GetLastUsedQrCodeType(
        monitor: getIt(),
        sharedPreferences: getIt(),
      ),
    );
    getIt.registerFactory(
      () => SetLastUsedQrCodeType(
        monitor: getIt(),
        sharedPreferences: getIt(),
      ),
    );

    getIt.registerLazySingleton(() => AppRouter());
    getIt.registerLazySingleton(() => CurrentQrCodeTypeNotifier());
    getIt.registerLazySingleton(() => IsUpdatingStyleNotifier());
  }

  @override
  Future<void> installInternal(GetIt getIt) async {
    await getIt<GetLastUsedQrCodeType>()().thenWhen(
      (exception) {},
      (value) => getIt<CurrentQrCodeTypeNotifier>().value = value,
    );
    qrCodeTypeChangeSubscription = getIt<CurrentQrCodeTypeNotifier>()
        .changes
        .listen((value) => getIt<SetLastUsedQrCodeType>()(value));
  }

  @override
  void dispose() {
    qrCodeTypeChangeSubscription?.cancel();
    super.dispose();
  }
}

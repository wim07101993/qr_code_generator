import 'dart:async';

import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:behaviour/behaviour.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/router/behaviours/get_last_used_qr_code.dart';
import 'package:qr_code_generator/shared/router/behaviours/set_last_used_qr_code.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/router/notifier/is_updating_style_notifier.dart';
import 'package:qr_code_generator/shared/shared_preferences/shared_preferences_feature.dart';

class RoutingFeature extends Feature {
  StreamSubscription? qrCodeTypeChangeSubscription;

  @override
  List<Type> get dependencies => [SharedPreferencesFeature];

  @override
  void registerTypes() {
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
  Future<void> install() async {
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

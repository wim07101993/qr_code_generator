import 'dart:async';

import 'package:behaviour/behaviour.dart';
import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/shared/router/app_router.dart';
import 'package:qr_code_generator/shared/router/behaviours/get_last_used_qr_code.dart';
import 'package:qr_code_generator/shared/router/behaviours/set_last_used_qr_code.dart';
import 'package:qr_code_generator/shared/router/notifier/current_qr_code_type_notifier.dart';
import 'package:qr_code_generator/shared/router/notifier/is_updating_style_notifier.dart';
import 'package:qr_code_generator/shared/shared_preferences/shared_preferences_feature.dart';

class RoutingFeature extends Feature {
  StreamSubscription? qrCodeTypeChangeSubscription;

  @override
  Iterable<Feature> get dependencies => [GetIt.I<SharedPreferencesFeature>()];

  @override
  void registerTypes() {
    GetIt.I.registerFactory(
      () => GetLastUsedQrCodeType(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => SetLastUsedQrCodeType(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
      ),
    );

    GetIt.I.registerLazySingleton(() => AppRouter());
    GetIt.I.registerLazySingleton(() => CurrentQrCodeTypeNotifier());
    GetIt.I.registerLazySingleton(() => IsUpdatingStyleNotifier());
  }

  @override
  Future<void> install() async {
    await loadLastUsedQrCode();
    qrCodeTypeChangeSubscription = GetIt.I<CurrentQrCodeTypeNotifier>()
        .changes
        .listen((value) => GetIt.I<SetLastUsedQrCodeType>()(value));
  }

  @override
  void dispose() {
    qrCodeTypeChangeSubscription?.cancel();
    super.dispose();
  }

  Future<void> loadLastUsedQrCode() async {
    return GetIt.I<GetLastUsedQrCodeType>()().thenWhen(
      (exception) {},
      (value) async {
        await value.feature?.ensureInstalled();
        GetIt.I<CurrentQrCodeTypeNotifier>().value = value;
      },
    );
  }
}

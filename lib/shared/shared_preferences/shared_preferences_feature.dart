import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFeature extends Feature {
  const SharedPreferencesFeature();

  @override
  void registerTypes() {
    GetIt.I.registerLazySingletonAsync(() => SharedPreferences.getInstance());
  }

  @override
  Future<void> install() {
    // by getting the instance here, it will be available instantly in other
    // places.
    return GetIt.I.getAsync<SharedPreferences>();
  }
}

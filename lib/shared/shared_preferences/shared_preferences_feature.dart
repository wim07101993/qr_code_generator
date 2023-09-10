import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFeature extends Feature {
  const SharedPreferencesFeature();
  @override
  void registerTypes() {
    getIt.registerLazySingletonAsync(() => SharedPreferences.getInstance());
  }

  @override
  Future<void> install() {
    // by getting the instance here, it will be available instantly in other
    // places.
    return getIt.getAsync<SharedPreferences>();
  }
}

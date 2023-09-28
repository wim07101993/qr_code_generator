import 'package:file_picker/file_picker.dart';
import 'package:flutter_app_base/flutter_app_base.dart';
import 'package:qr_code_generator/features/style/behaviours/get_embedded_image.dart';
import 'package:qr_code_generator/features/style/behaviours/load_style_settings.dart';
import 'package:qr_code_generator/features/style/behaviours/pick_file.dart';
import 'package:qr_code_generator/features/style/behaviours/remove_embedded_image.dart';
import 'package:qr_code_generator/features/style/behaviours/save_embedded_image_file.dart';
import 'package:qr_code_generator/features/style/behaviours/save_style_settings.dart';
import 'package:qr_code_generator/features/style/notifiers/style_settings.dart';

class QrCodeStyleFeature extends Feature {
  const QrCodeStyleFeature();

  @override
  void registerTypes() {
    GetIt.I.registerLazySingleton(
      () => StyleSettingsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
    GetIt.I.registerLazySingleton(() => FilePicker.platform);

    GetIt.I.registerFactoryAsync(
      () async => LoadStyleSettings(
        monitor: GetIt.I(),
        sharedPreferences: await GetIt.I.getAsync(),
        styleSettingsNotifier: GetIt.I(),
        getEmbeddedImage: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => SaveStyleSettings(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
        styleSettingsNotifier: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => GetEmbeddedImage(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => SaveEmbeddedImageFile(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => RemoveEmbeddedImage(
        monitor: GetIt.I(),
        sharedPreferences: GetIt.I(),
      ),
    );
    GetIt.I.registerFactory(
      () => PickFile(
        monitor: GetIt.I(),
        filePicker: GetIt.I(),
      ),
    );
  }

  @override
  Future<void> install() async {
    await GetIt.I
        .getAsync<LoadStyleSettings>()
        .then((loadStyleSettings) => loadStyleSettings());
    GetIt.I<StyleSettingsNotifier>().addListener(onEpcDataChanged);
  }

  @override
  void dispose() {
    GetIt.I<StyleSettingsNotifier>().removeListener(onEpcDataChanged);
    super.dispose();
  }

  void onEpcDataChanged() {
    GetIt.I<SaveStyleSettings>()();
  }
}

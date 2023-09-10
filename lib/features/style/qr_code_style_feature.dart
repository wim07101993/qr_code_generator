import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:file_picker/file_picker.dart';
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
    getIt.registerLazySingleton(
      () => StyleSettingsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
    getIt.registerLazySingleton(() => FilePicker.platform);

    getIt.registerFactoryAsync(
      () async => LoadStyleSettings(
        monitor: getIt(),
        sharedPreferences: await getIt.getAsync(),
        styleSettingsNotifier: getIt(),
        getEmbeddedImage: getIt(),
      ),
    );
    getIt.registerFactory(
      () => SaveStyleSettings(
        monitor: getIt(),
        sharedPreferences: getIt(),
        styleSettingsNotifier: getIt(),
      ),
    );
    getIt.registerFactory(
      () => GetEmbeddedImage(
        monitor: getIt(),
        sharedPreferences: getIt(),
      ),
    );
    getIt.registerFactory(
      () => SaveEmbeddedImageFile(
        monitor: getIt(),
        sharedPreferences: getIt(),
      ),
    );
    getIt.registerFactory(
      () => RemoveEmbeddedImage(
        monitor: getIt(),
        sharedPreferences: getIt(),
      ),
    );
    getIt.registerFactory(
      () => PickFile(
        monitor: getIt(),
        filePicker: getIt(),
      ),
    );
  }

  @override
  Future<void> install() async {
    await getIt
        .getAsync<LoadStyleSettings>()
        .then((loadStyleSettings) => loadStyleSettings());
    getIt<StyleSettingsNotifier>().addListener(onEpcDataChanged);
    // Uncomment to default style to app logo style
    // final styleSettings = getIt<StyleSettingsNotifier>();
    // styleSettings.value = StyleSettings(
    //   eyeStyle: const QrEyeStyle(
    //     color: Color(0xfff13de7),
    //     eyeShape: QrEyeShape.square,
    //   ),
    //   dataModuleStyle: const QrDataModuleStyle(
    //     color: Color(0xff4d0e8d),
    //     dataModuleShape: QrDataModuleShape.square,
    //   ),
    //   embeddedImageFilePath:
    //       '$HOME/source/repos/qr_code_generator/logo_with_background.png',
    // );
  }

  @override
  void dispose() {
    getIt<StyleSettingsNotifier>().removeListener(onEpcDataChanged);
    super.dispose();
  }

  void onEpcDataChanged() {
    getIt<SaveStyleSettings>()();
  }
}

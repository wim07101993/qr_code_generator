import 'package:ansicolor/ansicolor.dart';
import 'package:beaver_dependency_management/beaver_dependency_management.dart';
import 'package:behaviour/behaviour.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:qr_code_generator/shared/get_it/get_it_extensions.dart';
import 'package:qr_code_generator/shared/logging/logging_track.dart';

class LoggingFeature extends Feature {
  const LoggingFeature();

  @override
  void registerTypes() {
    getIt.registerLazySingleton<LogSink>(() {
      final prettyFormatter = PrettyFormatter();
      return PrintSink(
        LevelDependentFormatter(
          defaultFormatter: SimpleFormatter(),
          severe: prettyFormatter,
          shout: prettyFormatter,
        ),
      );
    });

    getIt.registerFactoryParam<Logger, String, dynamic>(
      (loggerName, _) => _loggerFactory(loggerName),
    );

    getIt.registerFactory<BehaviourMonitor>(
      () => getIt.monitor<LoggingTrack>(),
    );
    getIt.registerFactoryParam<LoggingTrack, BehaviourMixin, dynamic>(
      (behaviour, _) => LoggingTrack(
        behaviour: behaviour,
        logger: getIt.logger(behaviour.runtimeType.toString()),
      ),
    );
  }

  @override
  Future<void> install() {
    hierarchicalLoggingEnabled = true;
    recordStackTraceAtLevel = Level.SEVERE;
    Logger.root.level = Level.ALL;
    ansiColorDisabled = false;
    return Future.value();
  }

  Logger _loggerFactory(String loggerName) {
    final instanceName = '$loggerName-logger';
    if (getIt.isRegistered<Logger>(instanceName: instanceName)) {
      return getIt.get<Logger>(instanceName: instanceName);
    } else {
      final logger = Logger.detached(loggerName)..level = Level.ALL;
      getIt.registerSingleton<Logger>(
        logger,
        instanceName: instanceName,
        dispose: (instance) => instance.clearListeners(),
      );
      getIt<LogSink>().listenTo(logger.onRecord);
      return logger;
    }
  }
}

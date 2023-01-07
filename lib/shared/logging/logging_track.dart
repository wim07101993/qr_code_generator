import 'package:behaviour/behaviour.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';

class LoggingTrack extends BehaviourTrack {
  const LoggingTrack({
    required BehaviourMixin behaviour,
    required this.logger,
  }) : super(behaviour);

  final Logger logger;

  @override
  void addAttribute(String key, Object value) {}

  @override
  void end() => logger.v('done ${behaviour.description}');

  @override
  void start() => logger.v('start ${behaviour.description}');

  @override
  void stopWithError(Object error, StackTrace stackTrace) {
    logger.wtf('error while ${behaviour.description}', error, stackTrace);
  }

  @override
  void stopWithException(Exception exception, StackTrace stackTrace) {
    logger.severe(
      'exception while ${behaviour.description}',
      exception,
      stackTrace,
    );
  }
}

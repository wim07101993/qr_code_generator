import 'package:behaviour/behaviour.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_generator/shared/logging/get_it_behaviour_monitor.dart';

extension GetItExtensions on GetIt {
  Logger logger<T>([String? loggerName]) {
    return get<Logger>(param1: loggerName ?? T.runtimeType.toString());
  }

  GetItBehaviourMonitor<T> monitor<T extends BehaviourTrack>() {
    return GetItBehaviourMonitor(getIt: this);
  }
}

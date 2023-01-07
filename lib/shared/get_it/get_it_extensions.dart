import 'package:behaviour/behaviour.dart';
import 'package:collection/collection.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';
import 'package:qr_code_generator/shared/logging/get_it_behaviour_monitor.dart';

extension GetItExtensions on GetIt {
  void registerDependenciesOfInstallers() {
    final installers = get<List<Installer>>();
    final groupedByPriority = installers
        .where((installer) => !installer.hasRegisteredDependencies)
        .groupListsBy((installer) => installer.priority);

    final priorities = groupedByPriority.keys..sorted((a, b) => a.compareTo(b));
    for (final key in priorities) {
      final installers = groupedByPriority[key];
      if (installers == null) {
        continue;
      }
      for (final installer in installers) {
        installer.registerDependenciesInternal(this);
      }
    }
  }

  Future<void> installInstallers() async {
    final installers = get<List<Installer>>();
    final groupedByPriority = installers
        .where((installer) => !installer.isInstalled)
        .groupListsBy((installer) => installer.priority);

    final priorities = groupedByPriority.keys..sorted((a, b) => a.compareTo(b));
    for (final key in priorities) {
      final installers = groupedByPriority[key];
      if (installers == null) {
        continue;
      }
      await Future.wait(installers.map((installer) => installer.install(this)));
    }
  }

  Logger logger<T>([String? loggerName]) {
    return get<Logger>(param1: loggerName ?? T.runtimeType.toString());
  }

  GetItBehaviourMonitor<T> monitor<T extends BehaviourTrack>() {
    return GetItBehaviourMonitor(getIt: this);
  }
}

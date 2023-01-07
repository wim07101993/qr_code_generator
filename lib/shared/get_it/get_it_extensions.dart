import 'package:collection/collection.dart';
import 'package:qr_code_generator/shared/get_it/installer.dart';

extension GetItExtensions on GetIt {
  void registerDependenciesOfInstallers() {
    final installers = get<List<Installer>>();
    final groupedByPriority = installers.groupListsBy((item) => item.priority);
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
    final groupedByPriority = installers.groupListsBy((item) => item.priority);
    final priorities = groupedByPriority.keys..sorted((a, b) => a.compareTo(b));
    for (final key in priorities) {
      final installers = groupedByPriority[key];
      if (installers == null) {
        continue;
      }
      await Future.wait(
          installers.map((installer) => installer.installInternal(this)));
    }
  }
}

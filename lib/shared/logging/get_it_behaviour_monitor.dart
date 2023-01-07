import 'package:behaviour/behaviour.dart';
import 'package:get_it/get_it.dart';

class GetItBehaviourMonitor<T extends BehaviourTrack>
    implements BehaviourMonitor {
  const GetItBehaviourMonitor({
    required this.getIt,
  });

  final GetIt getIt;

  @override
  BehaviourTrack? createBehaviourTrack(BehaviourMixin behaviour) {
    return getIt<T>(param1: behaviour);
  }
}

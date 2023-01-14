import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

class NavigationNotifier extends ChangeNotifier {
  void onNavigate(List<RouteMatch> routes) => notifyListeners();
}

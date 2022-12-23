// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    EpcQrCodeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EpcQrCodeScreen(),
      );
    },
    StyleRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const StyleScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'epc',
              fullMatch: true,
            ),
            RouteConfig(
              '/#redirect',
              path: '/',
              parent: HomeRoute.name,
              redirectTo: 'epc',
              fullMatch: true,
            ),
            RouteConfig(
              EpcQrCodeRoute.name,
              path: 'epc',
              parent: HomeRoute.name,
            ),
            RouteConfig(
              StyleRoute.name,
              path: 'style',
              parent: HomeRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [EpcQrCodeScreen]
class EpcQrCodeRoute extends PageRouteInfo<void> {
  const EpcQrCodeRoute()
      : super(
          EpcQrCodeRoute.name,
          path: 'epc',
        );

  static const String name = 'EpcQrCodeRoute';
}

/// generated route for
/// [StyleScreen]
class StyleRoute extends PageRouteInfo<void> {
  const StyleRoute()
      : super(
          StyleRoute.name,
          path: 'style',
        );

  static const String name = 'StyleRoute';
}

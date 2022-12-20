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
    EpcQrCodeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EpcQrCodeScreen(),
      );
    },
    QrCodeStyleRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const QrCodeStyleScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          EpcQrCodeRoute.name,
          path: '/',
        ),
        RouteConfig(
          QrCodeStyleRoute.name,
          path: '/qr-code-style-screen',
        ),
      ];
}

/// generated route for
/// [EpcQrCodeScreen]
class EpcQrCodeRoute extends PageRouteInfo<void> {
  const EpcQrCodeRoute()
      : super(
          EpcQrCodeRoute.name,
          path: '/',
        );

  static const String name = 'EpcQrCodeRoute';
}

/// generated route for
/// [QrCodeStyleScreen]
class QrCodeStyleRoute extends PageRouteInfo<void> {
  const QrCodeStyleRoute()
      : super(
          QrCodeStyleRoute.name,
          path: '/qr-code-style-screen',
        );

  static const String name = 'QrCodeStyleRoute';
}

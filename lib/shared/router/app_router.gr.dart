// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    TextQrCodeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TextQrCodeScreen(),
      );
    },
    StyleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StyleScreen(),
      );
    },
    EpcQrCodeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EpcQrCodeScreen(),
      );
    },
  };
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TextQrCodeScreen]
class TextQrCodeRoute extends PageRouteInfo<void> {
  const TextQrCodeRoute({List<PageRouteInfo>? children})
      : super(
          TextQrCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'TextQrCodeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StyleScreen]
class StyleRoute extends PageRouteInfo<void> {
  const StyleRoute({List<PageRouteInfo>? children})
      : super(
          StyleRoute.name,
          initialChildren: children,
        );

  static const String name = 'StyleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EpcQrCodeScreen]
class EpcQrCodeRoute extends PageRouteInfo<void> {
  const EpcQrCodeRoute({List<PageRouteInfo>? children})
      : super(
          EpcQrCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EpcQrCodeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

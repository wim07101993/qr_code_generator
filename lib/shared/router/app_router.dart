import 'package:auto_route/auto_route.dart';
import 'package:qr_code_generator/features/epc/widgets/epc_qr_code_screen.dart';
import 'package:qr_code_generator/features/style/widgets/style_screen.dart';
import 'package:qr_code_generator/features/text/widgets/text_qr_code_screen.dart';
import 'package:qr_code_generator/home/widgets/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, children: [
      // RedirectRoute(path: '/', redirectTo: 'text'),
      AutoRoute(page: TextQrCodeRoute.page, path: 'text', initial: true),
      AutoRoute(page: EpcQrCodeRoute.page, path: 'epc'),
      AutoRoute(page: StyleRoute.page, path: 'style'),
    ]),
  ];
}

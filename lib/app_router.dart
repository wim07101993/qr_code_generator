import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc/widgets/epc_qr_code_screen.dart';
import 'package:qr_code_generator/home/widgets/home_screen.dart';
import 'package:qr_code_generator/style/widgets/style_screen.dart';
import 'package:qr_code_generator/text/widgets/text_qr_code_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeScreen,
      initial: true,
      children: [
        RedirectRoute(path: '/', redirectTo: 'epc'),
        AutoRoute(page: EpcQrCodeScreen, path: 'epc', initial: true),
        AutoRoute(page: TextQrCodeScreen, path: 'text'),
        AutoRoute(page: StyleScreen, path: 'style'),
      ],
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}

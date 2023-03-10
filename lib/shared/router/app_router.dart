import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/widgets/epc_qr_code_screen.dart';
import 'package:qr_code_generator/features/style/widgets/style_screen.dart';
import 'package:qr_code_generator/features/text/widgets/text_qr_code_screen.dart';
import 'package:qr_code_generator/home/widgets/home_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeScreen,
      initial: true,
      children: [
        RedirectRoute(path: '/', redirectTo: 'text'),
        AutoRoute(page: TextQrCodeScreen, path: 'text', initial: true),
        AutoRoute(page: EpcQrCodeScreen, path: 'epc'),
        AutoRoute(page: StyleScreen, path: 'style'),
      ],
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}

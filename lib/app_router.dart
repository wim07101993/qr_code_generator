import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc/widgets/epc_qr_code_screen.dart';
import 'package:qr_code_generator/qr_code_style/widgets/qr_code_style_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: EpcQrCodeScreen, initial: true),
    AutoRoute(page: QrCodeStyleScreen),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}

import 'dart:async';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/shared/l10n/exception_extensions.dart';

extension ExceptionOrLocalizationExtension<TSuccess>
    on FutureOr<ExceptionOr<TSuccess>> {
  Future<void> handleException(
    BuildContext context, {
    required bool Function() isMounted,
  }) async {
    await thenWhen(
      (exception) {
        if (isMounted()) {
          showException(context, exception);
        }
      },
      (value) {},
    );
  }
}

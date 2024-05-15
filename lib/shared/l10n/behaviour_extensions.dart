import 'dart:async';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/shared/l10n/exception_extensions.dart';

extension ExceptionOrLocalizationExtension<TSuccess>
    on FutureOr<ExceptionOr<TSuccess>> {
  FutureOr<void> handleException(
    BuildContext context, {
    required bool Function() isMounted,
  }) {
    return thenWhen(
      (exception) {
        if (isMounted()) {
          showException(context, exception);
        }
      },
      (value) {},
    );
  }
}

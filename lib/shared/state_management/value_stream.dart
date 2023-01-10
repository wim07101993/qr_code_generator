import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class ValueStream<T> extends ValueNotifier<T> {
  ValueStream(super.value) {
    addListener(onValueChanged);
  }

  final StreamController<T> _streamController = StreamController.broadcast();

  Stream<T> get changes => _streamController.stream;

  @mustCallSuper
  void onValueChanged() => _streamController.add(value);

  @override
  void dispose() {
    removeListener(onValueChanged);
    super.dispose();
  }
}

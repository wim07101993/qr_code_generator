import 'package:flutter/foundation.dart';

class ForwardingNotifier<TValue> extends ChangeNotifier
    implements ValueListenable<TValue> {
  ForwardingNotifier({
    required this.listenable,
    required this.valueGetter,
  }) {
    listenable.addListener(notifyListeners);
  }

  final Listenable listenable;
  final TValue Function() valueGetter;

  @override
  TValue get value => valueGetter();

  @override
  void dispose() {
    listenable.removeListener(notifyListeners);
    super.dispose();
  }
}

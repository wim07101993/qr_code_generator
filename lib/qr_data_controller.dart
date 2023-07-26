import 'package:flutter/foundation.dart';

class QrDataController extends ChangeNotifier
    implements ValueListenable<String> {
  QrDataController({
    required this.listenable,
    required this.valueGetter,
  }) {
    listenable.addListener(onTextChanged);
  }

  static const int maxLength = 2953;

  final Listenable listenable;
  final String Function() valueGetter;
  String _value = '';

  @override
  String get value => _value;

  void onTextChanged() {
    final text = valueGetter();
    if (text.length > maxLength) {
      return;
    }
    _value = text;
    notifyListeners();
  }

  @override
  void dispose() {
    listenable.removeListener(onTextChanged);
    super.dispose();
  }
}

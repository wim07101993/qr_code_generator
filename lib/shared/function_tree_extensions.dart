import 'package:function_tree/function_tree.dart';

extension FunctionTreeStringExtensions on String {
  num? tryInterpret() {
    try {
      return interpret();
    } catch (e) {
      return null;
    }
  }
}

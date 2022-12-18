import 'package:qr_code_generator/models/epc_data_writer.dart';

enum EpcVersion implements EpcDataWriter {
  version1(1),
  version2(2);

  const EpcVersion(this.value);

  final int value;

  @override
  String toEpcDataString() => value.toString().padLeft(3, '0');
}

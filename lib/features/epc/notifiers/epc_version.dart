enum EpcVersion {
  version1(1),
  version2(2);

  const EpcVersion(this.value);

  final int value;

  String toEpcDataString() => value.toString().padLeft(3, '0');
}

enum EpcCharacterSet {
  utf8(1),
  iso8859_1(2),
  iso8859_2(3),
  iso8859_4(4),
  iso8859_5(5),
  iso8859_7(6),
  iso8859_10(7),
  iso8859_15(8);

  const EpcCharacterSet(this.value);

  final int value;

  String toEpcDataString() => value.toString();
}

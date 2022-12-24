extension JsonExtensions on Map<String, dynamic> {
  int? getInt(String key) => this[key] as int?;
  double? getDouble(String key) => this[key] as double?;
  String? getString(String key) => this[key] as String?;
  bool? getBool(String key) => this[key] as bool?;
  Map<String, dynamic>? getObject(String key) =>
      this[key] as Map<String, dynamic>?;
}

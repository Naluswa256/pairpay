Map<String, dynamic> convertMap(Map<String, Object?>? map) {
  if (map == null) return {};

  final result = <String, dynamic>{};
  map.forEach((key, value) {
    if (value == null) {
      result[key] = null;
    } else if (value is Map<String, Object?>) {
      result[key] = convertMap(value);
    } else if (value is List) {
      result[key] = value.map((e) => e is Map<String, Object?> ? convertMap(e) : e).toList();
    } else {
      result[key] = value;
    }
  });
  return result;
}

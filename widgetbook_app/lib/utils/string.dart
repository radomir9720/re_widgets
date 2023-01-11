extension StringExtension on String {
  String? get notEmptyOrNull {
    return isEmpty ? null : this;
  }
}

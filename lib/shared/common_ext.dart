extension StringExt on String? {
  String orEmpty() {
    return this ?? "";
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}

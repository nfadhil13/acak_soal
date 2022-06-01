extension StringExtenstion on String? {
  double? toDoubleOrNull() {
    final value = this;
    if (value == null) return null;
    return double.tryParse(value);
  }

  int? toIntOrNull() {
    final value = this;
    if (value == null) return null;
    return int.tryParse(value);
  }

  bool isEmail() {
    final value = this;
    return value != null
        ? RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)
        : false;
  }
}

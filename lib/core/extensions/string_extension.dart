extension StringX on String {
  int? toInt() {
    return int.tryParse(this);
  }
}

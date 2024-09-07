extension StringX on String {
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get capitalizeEachWord {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalized).join(' ');
  }
}

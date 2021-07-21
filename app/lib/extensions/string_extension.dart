extension StringExtension on String {
  String get capitalizedString {
    final capitalized = StringBuffer();
    var uppercaseNext = false;

    for (final rune in runes) {
      final char = String.fromCharCode(rune);
      if (char == ' ') {
        capitalized.write(char);
        uppercaseNext = true;
        continue;
      }
      capitalized.write(uppercaseNext ? char.toUpperCase() : char);
      uppercaseNext = false;
    }
    return capitalized.toString();
  }
}

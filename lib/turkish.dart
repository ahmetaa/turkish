library turkish;

final _Turkish turkish = new _Turkish();

class _Turkish {

  int _latinCapitalLetterICode = 0x49;
  int _latinSmallLetterICode = 0x69;

  /**
   * Returns upper case form of a Turkish String.
   */
  String toUpperCase(String input) {
    if (input.length == 0) return "";
    if (input.length == 1) return _toUpper1Length(input);
    var buffer = new StringBuffer();
    List<int> toAppend = new List<int>();
    for (int codeUnit in input.codeUnits) {
      if (codeUnit == _latinSmallLetterICode) {
        if (toAppend.length > 0) {
          buffer.write(new String.fromCharCodes(toAppend).toUpperCase());
          toAppend.clear();
        }
        buffer.write("İ");
      } else
        toAppend.add(codeUnit);
    }
    if (toAppend.length > 0) {
      buffer.write(new String.fromCharCodes(toAppend).toUpperCase());
    }
    return buffer.toString();
  }

  String _toUpper1Length(String input) {
    if (input.codeUnitAt(0) == _latinSmallLetterICode)
      return "İ";
    else
      return input.toUpperCase();
  }

  /**
   * Returns lower case form of a Turkish String.
   */
  String toLowerCase(String input) {
    if (input.length == 0) return "";
    if (input.length == 1) return _toLower1Length(input);
    var buffer = new StringBuffer();
    List<int> toAppend = new List<int>();
    for (int codeUnit in input.codeUnits) {
      if (codeUnit == _latinCapitalLetterICode) {
        if (toAppend.length > 0) {
          buffer.write(new String.fromCharCodes(toAppend).toLowerCase());
          toAppend.clear();
        }
        buffer.write("ı");
      } else {
        toAppend.add(codeUnit);
      }
    }
    if (toAppend.length > 0) {
      buffer.write(new String.fromCharCodes(toAppend).toLowerCase());
    }
    return buffer.toString();
  }

  String _toLower1Length(String input) {
    if (input.codeUnitAt(0) == _latinCapitalLetterICode)
      return "ı";
    else
      return input.toLowerCase();
  }

  /// Some code is used from Dart core.
  static int _compareTr(String a, String b, bool ignoreCase) {
    int aLength = a.length;
    int bLength = b.length;
    int len = (aLength < bLength) ? aLength : bLength;
    for (int i = 0; i < len; i++) {
      int aCodePoint = a.codeUnitAt(i);
      int bCodePoint = b.codeUnitAt(i);

      int aCodePointTr = ignoreCase != true
          ? _codeUnitLookup.getOrder(aCodePoint)
          : _codeUnitLookup.getOrderIgnoreCase(aCodePoint);

      int bCodePointTr = ignoreCase != true
          ? _codeUnitLookup.getOrder(bCodePoint)
          : _codeUnitLookup.getOrderIgnoreCase(bCodePoint);

      if (aCodePointTr >= 0 && bCodePointTr >= 0) {
        aCodePoint = aCodePointTr;
        bCodePoint = bCodePointTr;
      }
      if (aCodePoint < bCodePoint) {
        return -1;
      }
      if (aCodePoint > bCodePoint) {
        return 1;
      }
    }
    if (aLength < bLength) return -1;
    if (aLength > bLength) return 1;
    return 0;
  }

  /**
   * Returns Title cased form of a Turkish String.
   */
  String toTitleCase(String input) {
    if (input.length == 0) return "";
    if (input.length == 1) return _toUpper1Length(input);
    return "${_toUpper1Length(input.substring(0, 1))}${toLowerCase(
        input.substring(1))}";
  }

  /// Turkish alphabet aware String Comparator.
  final Comparator<String> comparator =
      (String a, String b) => _compareTr(a, b, false);

  /// Case insensitive Turkish alphabet aware String Comparator.
  final Comparator<String> comparatorIgnoreCase =
      (String a, String b) => _compareTr(a, b, true);

}

final _Lookup _codeUnitLookup = new _Lookup();

class _Lookup {
  List<int> orderLookup = new List<int>.filled(0x160, -1);
  List<int> orderLookupIgnoreCase = new List<int>.filled(0x160, -1);

  _Lookup() {
    // English characters and Turkish characters with circumflex are included
    // in alphabet.
    var alphabet =
        "AÂBCÇDEFGĞHIİÎJKLMNOÖPQRSŞTUÛÜVWXYZaâbcçdefgğhıiîjklmnoöpqrsştuûüvwxyz";
    var letterCount = alphabet.length ~/ 2;
    for (int i = 0; i < alphabet.length; ++i) {
      int index = alphabet.codeUnitAt(i);
      orderLookup[index] = i;
      orderLookupIgnoreCase[index] = i % letterCount;
    }
  }

  bool _isOutOfTable(int codeUnit) => codeUnit < 0x41 || codeUnit > 0x15F;

  int getOrder(int codeUnit) =>
      _isOutOfTable(codeUnit) ? -1 : orderLookup[codeUnit];

  int getOrderIgnoreCase(int codeUnit) =>
      _isOutOfTable(codeUnit) ? -1 : orderLookupIgnoreCase[codeUnit];

}

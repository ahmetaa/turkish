final _turkish = _Turkish();

extension TurkishStrings on String {
  String toUpperCaseTR() => _turkish.toUpperCase(this);

  String toLowerCaseTR() => _turkish.toLowerCase(this);

  String toTitleCaseTR() => _turkish.toTitleCase(this);

  String toCapitalizeTR() => _turkish.capitalize(this) ?? "error";

  String toCapitalizeFirstTR() => _turkish.capitalizeFirst(this) ?? "error";

  int compareToTR(String other, [bool ignoreCase = false]) => _turkish.compareToTr(this, other, ignoreCase);
}

/// Provides methods for correct Turkish case conversions and collation.
class _Turkish {
  final int _latinCapitalLetterICode = 0x49;
  final int _latinSmallLetterICode = 0x69;

  /// Returns upper case form of a Turkish String.
  String toUpperCase(String input) {
    if (input.isEmpty) return "";
    if (input.length == 1) return _toUpper1Length(input);
    final buffer = StringBuffer();
    final toAppend = <int>[];
    for (final codeUnit in input.codeUnits) {
      if (codeUnit == _latinSmallLetterICode) {
        if (toAppend.isNotEmpty) {
          buffer.write(String.fromCharCodes(toAppend).toUpperCase());
          toAppend.clear();
        }
        buffer.write("İ");
      } else {
        toAppend.add(codeUnit);
      }
    }
    if (toAppend.isNotEmpty) {
      buffer.write(String.fromCharCodes(toAppend).toUpperCase());
    }
    return buffer.toString();
  }

  String _toUpper1Length(String input) => (input.codeUnitAt(0) == _latinSmallLetterICode) ? "İ" : input.toUpperCase();

  /// Returns lower case form of a Turkish String.
  String toLowerCase(String input) {
    if (input.isEmpty) return "";
    if (input.length == 1) return _toLower1Length(input);
    final buffer = StringBuffer();
    final toAppend = <int>[];
    for (final codeUnit in input.codeUnits) {
      if (codeUnit == _latinCapitalLetterICode) {
        if (toAppend.isNotEmpty) {
          buffer.write(String.fromCharCodes(toAppend).toLowerCase());
          toAppend.clear();
        }
        buffer.write("ı");
      } else {
        toAppend.add(codeUnit);
      }
    }
    if (toAppend.isNotEmpty) {
      buffer.write(String.fromCharCodes(toAppend).toLowerCase());
    }
    return buffer.toString();
  }

  String _toLower1Length(String input) => (input.codeUnitAt(0) == _latinCapitalLetterICode) ? "ı" : input.toLowerCase();

  int compareToTr(String a, String b, bool ignoreCase) => _compareToTr(a, b, ignoreCase);

  /// Some code is used from Dart core.
  static int _compareToTr(String a, String b, bool ignoreCase) {
    final aLength = a.length;
    final bLength = b.length;
    final len = (aLength < bLength) ? aLength : bLength;
    for (var i = 0; i < len; i++) {
      var aCodePoint = a.codeUnitAt(i);
      var bCodePoint = b.codeUnitAt(i);

      final aCodePointTr = ignoreCase != true ? _codeUnitLookup.getOrder(aCodePoint) : _codeUnitLookup.getOrderIgnoreCase(aCodePoint);

      final bCodePointTr = ignoreCase != true ? _codeUnitLookup.getOrder(bCodePoint) : _codeUnitLookup.getOrderIgnoreCase(bCodePoint);

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

  /// Returns Title cased form of a Turkish String.
  String toTitleCase(String input) {
    if (input.isEmpty) return "";
    if (input.length == 1) return _toUpper1Length(input);
    return "${_toUpper1Length(input.substring(0, 1))}${toLowerCase(input.substring(1))}";
  }

  /// Turkish alphabet aware String Comparator.
  Comparator<String> get comparator => (String a, String b) => _compareToTr(a, b, false);

  /// Case insensitive Turkish alphabet aware String Comparator.
  Comparator<String> get comparatorIgnoreCase => (String a, String b) => _compareToTr(a, b, true);

  String? capitalize(String value) {
    if (_isNull(value)) return null;
    if (_isBlank(value)!) return value;
    return value.split(' ').map(capitalizeFirst).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String? capitalizeFirst(String s) {
    if (_isNull(s)) return null;
    if (_isBlank(s)!) return s;
    return s[0].toUpperCaseTR() + s.substring(1).toLowerCaseTR();
  }
}

final _Lookup _codeUnitLookup = _Lookup();

// English characters and Turkish characters with circumflex are included
// in alphabet.
const alphabet = "AÂBCÇDEFGĞHIİÎJKLMNOÖPQRSŞTUÛÜVWXYZaâbcçdefgğhıiîjklmnoöpqrsştuûüvwxyz";

class _Lookup {
  List<int> orderLookup = List<int>.filled(0x160, -1);
  List<int> orderLookupIgnoreCase = List<int>.filled(0x160, -1);

  _Lookup() {
    const letterCount = alphabet.length ~/ 2;
    for (var i = 0; i < alphabet.length; ++i) {
      final index = alphabet.codeUnitAt(i);
      orderLookup[index] = i;
      orderLookupIgnoreCase[index] = i % letterCount;
    }
  }

  bool _isOutOfTable(int codeUnit) => codeUnit < 0x41 || codeUnit > 0x15F;

  int getOrder(int codeUnit) => _isOutOfTable(codeUnit) ? -1 : orderLookup[codeUnit];

  int getOrderIgnoreCase(int codeUnit) => _isOutOfTable(codeUnit) ? -1 : orderLookupIgnoreCase[codeUnit];
}

bool _isNull(dynamic value) => value == null;
bool? _isBlank(dynamic value) {
  return _isEmpty(value);
}

bool? _isEmpty(dynamic value) {
  if (value is String) {
    return value.toString().trim().isEmpty;
  }
  if (value is Iterable || value is Map) {
    return value.isEmpty as bool?;
  }
  return false;
}

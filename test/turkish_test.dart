library turkish_test;

import 'package:test/test.dart';
import 'package:turkish/turkish.dart';

main() {
  test('toUpperCaseTr', () {
    expect(turkish.toUpperCase('abcçdefgğhıijklmnoöprsştuüvyz'),
        'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ');
    expect(turkish.toUpperCase('ıijklmnoöprsştuüvyz'), 'IİJKLMNOÖPRSŞTUÜVYZ');
    expect(turkish.toUpperCase('abcçdefgğhı'), 'ABCÇDEFGĞHI');
    expect(turkish.toUpperCase('ı'), 'I');
    expect(turkish.toUpperCase('i'), 'İ');
    expect(turkish.toUpperCase('πiıδ'), 'ΠİIΔ');
    expect(turkish.toUpperCase(''), '');
    expect(turkish.toUpperCase('\u{1D11E}'), '\u{1D11E}');
    expect(turkish.toUpperCase('i\u{1D11E}i'), 'İ\u{1D11E}İ');
  });

  test('toLowerCaseTr', () {
    expect(turkish.toLowerCase('ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ'),
        'abcçdefgğhıijklmnoöprsştuüvyz');
    expect(turkish.toLowerCase('IİJKLMNOÖPRSŞTUÜVYZ'), 'ıijklmnoöprsştuüvyz');
    expect(turkish.toLowerCase('ABCÇDEFGĞHI'), 'abcçdefgğhı');
    expect(turkish.toLowerCase('I'), 'ı');
    expect(turkish.toLowerCase('İ'), 'i');
    expect(turkish.toLowerCase('ΠİIΔ'), 'πiıδ');
    expect(turkish.toLowerCase(''), '');
  });

  test('toTitleCaseTr', () {
    expect(turkish.toTitleCase('ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ'),
        'Abcçdefgğhıijklmnoöprsştuüvyz');
    expect(turkish.toTitleCase('IİJKLMNOÖPRSŞTUÜVYZ'), 'Iijklmnoöprsştuüvyz');
    expect(turkish.toTitleCase('ABCÇDEFGĞHI'), 'Abcçdefgğhı');
    expect(turkish.toTitleCase('abcçdefgğhıijklmnoöprsştuüvyz'),
        'Abcçdefgğhıijklmnoöprsştuüvyz');
    expect(turkish.toTitleCase('ijklmnoöprsştuüvyz'), 'İjklmnoöprsştuüvyz');
    expect(turkish.toTitleCase('abcçdefgğhı'), 'Abcçdefgğhı');
    expect(turkish.toTitleCase('I'), 'I');
    expect(turkish.toTitleCase('İ'), 'İ');
    expect(turkish.toTitleCase('II'), 'Iı');
    expect(turkish.toTitleCase('İİ'), 'İi');
    expect(turkish.toTitleCase(''), '');
  });

  test('compareToTr', () {
    expect(turkish.compareToTr('d', 'ç', false), 1);
    expect(turkish.compareToTr('d', 'Ç', false), 1);
    expect(turkish.compareToTr('D', 'Ç', false), 1);
    expect(turkish.compareToTr('D', 'ç', false), -1);
    expect(turkish.compareToTr('Ç', 'ç', false), -1);
  });

  test('compareToTr Ignore Case', () {
    expect(turkish.compareToTr('d', 'ç', true), 1);
    expect(turkish.compareToTr('d', 'Ç', true), 1);
    expect(turkish.compareToTr('D', 'Ç', true), 1);
    expect(turkish.compareToTr('D', 'ç', true), 1);
    expect(turkish.compareToTr('Ç', 'ç', true), 0);
  });

  test('Comparator Test', () {
    expect(["d", "ç"]..sort(turkish.comparator), orderedEquals(["ç", "d"]));
    expect(["ü", "ş", "ö", "i", "ı", "ğ", "ç"]..sort(turkish.comparator),
        orderedEquals(["ç", "ğ", "ı", "i", "ö", "ş", "ü"]));
    expect(["Ü", "Ş", "Ö", "İ", "I", "Ğ", "Ç"]..sort(turkish.comparator),
        orderedEquals(["Ç", "Ğ", "I", "İ", "Ö", "Ş", "Ü"]));
    expect(["ü", "ş", "ö", "i", "ı", "ğ", "ç", "Ü", "Ş", "Ö", "İ", "I", "Ğ", "Ç"
    ]
      ..sort(turkish.comparator),
        orderedEquals([
          "Ç", "Ğ", "I", "İ", "Ö", "Ş", "Ü", "ç", "ğ", "ı", "i", "ö", "ş", "ü"
        ]));
    expect(["ü", "q"]..sort(turkish.comparator), orderedEquals(["q", "ü"]));
    expect(["ü", "πq"]..sort(turkish.comparator), orderedEquals(["ü", "πq"]));
    expect(["ü", "!q"]..sort(turkish.comparator), orderedEquals(["!q", "ü"]));
    expect(["ü", "Ü"]..sort(turkish.comparator), orderedEquals(["Ü", "ü"]));
    expect(["ü", ""]..sort(turkish.comparator), orderedEquals(["", "ü"]));
  });

  test('Comparator Test Ignore Case', () {
    expect(["D", "ç"]..sort(turkish.comparatorIgnoreCase),
        orderedEquals(["ç", "D"]));
    var list = [
      "ü", "ş", "ö", "i", "ı", "ğ", "ç", "Ü", "Ş", "Ö", "İ", "I", "Ğ", "Ç"];
    list.sort(turkish.comparatorIgnoreCase);
    expect(turkish.toLowerCase(list.toString()),
        "[ç, ç, ğ, ğ, ı, ı, i, i, ö, ö, ş, ş, ü, ü]");
    expect(
        ["Ü", "Ş", "Ö", "İ", "I", "Ğ", "Ç"]..sort(turkish.comparatorIgnoreCase),
        orderedEquals(["Ç", "Ğ", "I", "İ", "Ö", "Ş", "Ü"]));
    expect(["ü", ""]..sort(turkish.comparatorIgnoreCase),
        orderedEquals(["", "ü"]));
  });
}
turkish
=========

This library provides these functions for Turkish language for Dart:

- Converting strings to lower, upper and title case. 
- Regular and ignore case string sorting.

Some casing operations for Turkish does not work correctly in Dart core libraries because Dart uses default unicode mappings.
Default case mappings fails for Turkish `i->İ` and `I->ı` conversions.

**This library may not be necessary for Flutter or web projects if they use underlying system methods for locale specific text operations.
But it can be handy when that is not the case.**

Current implementation does not handle two code-unit variations. Complete special casing rules are defined [here](https://unicode.org/Public/UNIDATA/SpecialCasing.txt).  

## Usage

Add this line to pubspec.yaml:

    turkish: '>=0.2.0'

Add this line to the import section:
    
    import 'package:turkish/turkish.dart'

## Extension methods
There are three extension methods that can be used for upper, lower and title casing.

```dart
import 'package:turkish/turkish.dart';

// Uses extension methods.
main() {
  // upperCaseTr
  var inputL = "kısa şiir";
  print("UpperCase for [$inputL]");
  print("Default= ${inputL.toUpperCase()}, "
      "Turkish=${inputL.toUpperCaseTr()}\n");

  // lowerCaseTr
  var inputU = "KISA ŞİİR";
  print("LowerCase for [$inputU]");
  print("Default= ${inputU.toLowerCase()}, "
      "Turkish=${inputU.toLowerCaseTr()}\n");

  // compareToTr
  var zonguldak = "Zonguldak";
  var cankiri = "Çankırı";
  print("Comparison for [$zonguldak] and [$cankiri]");
  print("Default= ${zonguldak.compareTo(cankiri)}, "
      "Turkish=${zonguldak.compareToTr(cankiri)}\n");
}
```
	Output:
	UpperCase for [kısa şiir]
	Default= KISA ŞIIR, Turkish=KISA ŞİİR

	LowerCase for [KISA ŞİİR]
	Default= kisa şiir, Turkish=kısa şiir

	Comparison for [Zonguldak] and [Çankırı]
	Default= -1, Turkish=1


## 'turkish' object.
Also, for turkish specific sorting and casing 
a single object instance exposed from library called `turkish` can be used. 

See also related Pub [page](https://pub.dartlang.org/packages/turkish).

Example:  

```dart
import 'package:turkish/turkish.dart';

main() {
  // upperCaseTr
  var inputL = "kısa şiir";
  print("UpperCase for [$inputL]");
  print("Default= ${inputL.toUpperCase()}, "
      "Turkish=${turkish.toUpperCase(inputL)}\n");

  // lowerCaseTr
  var inputU = "KISA ŞİİR";
  print("LowerCase for [$inputU]");
  print("Default= ${inputU.toLowerCase()}, "
      "Turkish=${turkish.toLowerCase(inputU)}\n");

  // compareToTr
  var zonguldak = "Zonguldak";
  var cankiri = "Çankırı";
  print("Comparison for [$zonguldak] and [$cankiri]");
  print("Default= ${zonguldak.compareTo(cankiri)}, "
      "Turkish=${zonguldak.compareToTr(cankiri)}\n");

  // sort Default
  var list = ["Az", "ağ", "aç", "ad"];
  print("Input= $list");
  print("Default Sort= ${list..sort()}");

  // sort Turkish  
  list = ["Az", "ağ", "aç", "ad"];
  print("Turkish Sort= ${list..sort(turkish.comparator)}");

  // sort Turkish ignore case  
  list = ["Az", "ağ", "aç", "ad"];
  print("Turkish Sort Ignore Case= "
      "${list..sort(turkish.comparatorIgnoreCase)}");
}
```
	Output:
	UpperCase for [kısa şiir]
	Default= KISA ŞIIR, Turkish=KISA ŞİİR

	LowerCase for [KISA ŞİİR]
	Default= kisa şiir, Turkish=kısa şiir

	Comparison for [Zonguldak] and [Çankırı]
	Default= -1, Turkish=1

	Input= [Az, ağ, aç, ad]
	Default Sort= [Az, ad, aç, ağ]
	Turkish Sort= [Az, aç, ad, ağ]
	Turkish Sort Ignore Case= [aç, ad, ağ, Az]

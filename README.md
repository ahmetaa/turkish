turkish
=========

This library provides these functions for Turkish language for Dart:

- Converting strings to lower, upper and title case. 
- Regular and ignore case string sorting.

Casing operations for Turkish does not work correctly in Dart core libraries because Dart uses default unicode mappings.
Default case mappings fails for Turkish `i->İ` and `I->ı` conversions.

This library may not be necessary for Flutter or web projects if they use underlying system methods for locale specific text operations.
But it can be handy when that is not the case.  

Current implementation does not handle two code-unit variations. Complete special casing rules are defined [here](https://unicode.org/Public/UNIDATA/SpecialCasing.txt).  

## Usage

Add this line to pubspec.yaml:

    turkish: '>=0.1.0'

Add this line to the import section:
    
    import 'package:turkish/turkish'

There is a single object instance exposed from library called `turkish`. All operations are accessed through this object. 

See also related Pub [page](https://pub.dartlang.org/packages/turkish).

Example:  

	import 'package:turkish/turkish';
	...
	var inputL = "kısa şiir";
	print("UpperCase for [$inputL]");
	print("Default= ${inputL.toUpperCase()}, Turkish=${turkish.toUpperCase(inputL)}\n");

	var inputU = "KISA ŞİİR";
	print("LowerCase for [$inputU]");
	print("Default= ${inputU.toLowerCase()}, Turkish=${turkish.toLowerCase(inputU)}\n");

	var list = ["Az","ağ","aç","ad"];
	print("Input= $list");
	print("Default Sort= ${list..sort()}");

	list = ["Az","ağ","aç","ad"];
	print("Turkish Sort= ${list..sort(turkish.comparator)}");

	list = ["Az","ağ","aç","ad"];
	print("Turkish Sort Ignore Case= ${list..sort(turkish.comparatorIgnoreCase)}");

	Output:
	UpperCase for [kısa şiir]
	Default= KISA ŞIIR, Turkish=KISA ŞİİR

	LowerCase for [KISA ŞİİR]
	Default= kisa şiir, Turkish=kısa şiir

	Input= [Az, ağ, aç, ad]
	Default Sort= [Az, ad, aç, ağ]
	Turkish Sort= [Az, aç, ad, ağ]
	Turkish Sort Ignore Case= [aç, ad, ağ, Az]

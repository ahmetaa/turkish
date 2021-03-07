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
}
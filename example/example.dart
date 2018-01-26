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
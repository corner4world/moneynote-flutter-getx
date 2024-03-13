import 'package:get/get.dart';
import 'package:moneynote/generated/locales.g.dart';

String accountTabIndexToType(int index) {
  switch (index) {
    case 0:
      return 'CHECKING';
    case 1:
      return 'CREDIT';
    case 2:
      return 'ASSET';
    case 3:
      return 'DEBT';
  }
  throw Exception('tab index error');
}

String boolToString(bool val) {
  if (val) {
    return LocaleKeys.common_yes.tr;
  } else {
    return LocaleKeys.common_no.tr;
  }
}

bool isNullEmpty(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || "" == o;
}
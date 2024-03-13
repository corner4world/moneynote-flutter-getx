import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';

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

String removeDecimalZero(num? n) {
  if (n == null) return '';
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return n.toString().replaceAll(regex, "");
}

String dateFormatStr1() {
  String locale = Get.locale?.toString() ?? '';
  if (locale == 'en_US') {
    return 'MM/dd/yyyy HH:mm';
  } else if (locale == 'zh_CN') {
    return 'yyyy-MM-dd HH:mm';
  }
  return 'MM/dd/yyyy HH:mm';
}

String dateFormatStr2() {
  String locale = Get.locale?.toString() ?? '';
  if (locale == 'en_US') {
    return 'MM/dd/yyyy';
  } else if (locale == 'zh_CN') {
    return 'yyyy-MM-dd';
  }
  return 'MM/dd/yyyy';
}

String dateTimeFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat(dateFormatStr1()).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String dateFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat(dateFormatStr2()).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}
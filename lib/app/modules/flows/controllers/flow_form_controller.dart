import 'package:get/get.dart';
import '../../login/controllers/auth_controller.dart';
import '/app/core/base/base_controller.dart';

class FlowFormController extends BaseController {

  bool valid = false;
  Map<String, dynamic> form = { };
  List<Map<String, dynamic>> categories = [];

  String type;
  int action;
  Map<String, dynamic> currentRow;

  FlowFormController(this.type, this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    valid = action != 1;
    if (action == 2) {
      form = { ...currentRow };
    }
    if (action == 1) {
      form['book'] = Get.find<AuthController>().initState['book'];
      form['categories'] = [];
    }
  }

  void submit() async {

  }

  void tabClick(int index) {
    if (index == 0) {
      type = 'EXPENSE';
    } else if (index == 1) {
      type = 'INCOME';
    } else if (index == 2) {
      type = 'TRANSFER';
    } else {
      throw Exception('index error');
    }
    update();
  }

  void changeCategory(values) {
    categories = values;
    form['categories'] = List<Map<String, dynamic>>.from(values.map((e) {
      // 先要查找之前有没有，避免每次更新分类都将之前的金额清空了。
      return form['categories'].firstWhere((e1) => e1['categoryId'] == e['id'], orElse: () {
        return {
          'category': e['id'],
          'categoryName': e['name'],
          'amount': '',
          'convertedAmount': '',
        };
      });
    }));
    update();
    Get.back();
  }

  bool get needConvert {
    if (form['account'] == null) {
      return false;
    }
    if (type == 'EXPENSE' || type == 'INCOME') {
      return form['account']['currencyCode'] != form['book']['defaultCurrencyCode'];
    } else if (type == 'TRANSFER') {
      if (form['to'] == null) {
        return false;
      }
      return form['account']['currencyCode'] != form['to']['currencyCode'];
    }
    return false;
  }

  String get convertCode {
    if (type == 'TRANSFER') {
      return form['to']['currencyCode'];
    } else {
      return form['book']['defaultCurrencyCode'];
    }
  }

}
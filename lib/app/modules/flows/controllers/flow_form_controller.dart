import 'package:get/get.dart';
import '/app/core/base/base_repository.dart';
import '/app/modules/flows/controllers/flow_detail_controller.dart';
import '../../../core/utils/message.dart';
import '../../login/controllers/auth_controller.dart';
import '/app/core/base/base_controller.dart';
import 'flows_controller.dart';

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
    valid =true;
    if (action == 2) {
      form = { ...currentRow };
    }
    if (action == 1) {
      form['book'] = Get.find<AuthController>().initState['book'];
      form['categories'] = [];
      form['confirm'] = true;
      form['include'] = true;
    }
  }

  void submit() async {
    if (valid) {
      try {
        Message.showLoading();
        bool result = false;
        print(buildForm());
        if (action == 2) {
          result = await BaseRepository.update('balance-flows', currentRow['id'], buildForm());
        } else {
          result = await BaseRepository.add('balance-flows', buildForm());
        }
        if (result) {
          Get.back();
          Get.find<FlowsController>().reload();
          Get.find<FlowDetailController>().load();
        }
      } catch (_) {
        _.printError();
      } finally {
        // Message.disLoading();
      }
    }
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

  Map<String, dynamic> buildForm() {
    Map<String, dynamic> newForm = { ...form };
    newForm['type'] = type;
    if (form['book']?['value'] != null) {
      newForm['book'] = form['book']?['value'];
    }
    if (form['account']?['value'] != null) {
      newForm['account'] = form['account']?['value'];
    }
    if (form['to']?['value'] != null) {
      newForm['to'] = form['to']?['value'];
    }
    if (form['payees']?['value'] != null) {
      newForm['payees'] = [form['payees']?['value']];
    }
    if (!(form['tags']?.isEmpty ?? true)) {
      newForm['tags'] = form['tags'].map((e) => e['value']).toList();
    }
    return newForm;
  }

}
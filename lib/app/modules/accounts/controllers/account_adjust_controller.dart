import 'package:get/get.dart';
import 'package:formz/formz.dart';
import '../../../core/utils/message.dart';
import '/app/modules/accounts/controllers/account_detail_controller.dart';
import '/app/modules/accounts/controllers/accounts_controller.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '/app/core/base/base_controller.dart';
import '../../login/controllers/auth_controller.dart';
import '../data/account_repository.dart';


class AccountAdjustController extends BaseController {

  bool valid = false;
  Map<String, dynamic> form = { };
  NotEmptyNumFormz balanceFormz = const NotEmptyNumFormz.pure();
  dynamic book;

  int action;
  Map<String, dynamic> currentRow;

  AccountAdjustController(this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    book = Get.find<AuthController>().initState['book'];
    form['createTime'] = action == 1 ? DateTime.now().millisecondsSinceEpoch : currentRow['createTime'];
    form['bookId'] = book['value'];
  }

  void balanceChanged(String value) {
    balanceFormz = NotEmptyNumFormz.dirty(value: value);
    valid = Formz.validate([balanceFormz]);
    form['balance'] = value;
    update();
  }

  void bookChanged(dynamic value) {
    book = value;
    form['bookId'] = value['value'];
    update();
    Get.back();
  }

  void submit() async {
    if (valid) {
      try {
        Message.showLoading();
        bool result = false;
        switch (action) {
          case 1:
            result = await AccountRepository.createAdjust(currentRow['id'], form);
            break;
          case 2:
            result = await AccountRepository.updateAdjust(currentRow['id'], form);
            break;
        }
        if (result) {
          Get.back();
          // 更新成功要刷新列表页和详情页
          Get.find<AccountsController>().reload();
          Get.find<AccountDetailController>().load();
        }
      } catch (_) {
        _.printError();
      }
    }
  }


}
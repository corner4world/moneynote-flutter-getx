import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:moneynote/app/modules/accounts/controllers/account_detail_controller.dart';

import '../../../core/commons/form/not_empty_formz.dart';
import '../../../core/commons/form/not_empty_num_formz.dart';
import '../../login/controllers/auth_controller.dart';
import '../data/account_repository.dart';
import '/app/core/base/base_controller.dart';

class AccountAdjustController extends BaseController {

  bool valid = false;
  FormzSubmissionStatus submissionStatus = FormzSubmissionStatus.initial;
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
  }

  void submit() async {
    if (valid) {
      try {
        submissionStatus = FormzSubmissionStatus.inProgress;
        update();
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
          submissionStatus = FormzSubmissionStatus.success;
          Get.back();
          Get.find<AccountDetailController>().load();
        } else {
          submissionStatus = FormzSubmissionStatus.failure;
        }
      } catch (_) {
        submissionStatus = FormzSubmissionStatus.failure;
      }
    }
  }


}
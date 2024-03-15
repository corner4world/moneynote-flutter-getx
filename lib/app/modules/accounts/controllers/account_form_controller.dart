import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/core/base/base_repository.dart';
import '../../../core/utils/utils.dart';
import '../data/account_repository.dart';
import '/app/core/commons/form/not_empty_formz.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '../../login/controllers/auth_controller.dart';
import '/app/core/base/base_controller.dart';
import 'account_detail_controller.dart';
import 'accounts_controller.dart';

class AccountFormController extends BaseController {

  bool valid = false;
  FormzSubmissionStatus submissionStatus = FormzSubmissionStatus.initial;
  Map<String, dynamic> form = { };
  NotEmptyFormz nameFormz = const NotEmptyFormz.pure();
  NotEmptyNumFormz balanceFormz = const NotEmptyNumFormz.pure();

  String type;
  int action;
  Map<String, dynamic> currentRow;

  AccountFormController(this.type, this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    valid = action != 1;
    if (action == 2) {
      form = { ...currentRow };
      nameFormz = NotEmptyFormz.dirty(value: currentRow['name']);
      balanceFormz = NotEmptyNumFormz.dirty(value: removeDecimalZero(currentRow['balance']));
    }
    if (action == 1) {
      form['currencyCode'] = Get.find<AuthController>().initState['group']['defaultCurrencyCode'];
    }
    if (action == 1) {
      form['canExpense'] = true;
      form['canIncome'] = true;
      form['canTransferFrom'] = true;
      form['canTransferTo'] = true;
      form['include'] = true;
    }

  }

  void submit() async {
    if (valid) {
      try {
        submissionStatus = FormzSubmissionStatus.inProgress;
        update();
        bool result = false;
        switch (action) {
          case 1:
            result = await BaseRepository.add('accounts', {
              ...form,
              'type': type
            });
            break;
          case 2:
            result = await BaseRepository.update('accounts', currentRow['id'], form);
            break;
        }
        if (result) {
          submissionStatus = FormzSubmissionStatus.success;
          Get.back();
          Get.find<AccountDetailController>().load();
          Get.find<AccountsController>().reload();
        } else {
          submissionStatus = FormzSubmissionStatus.failure;
        }
      } catch (_) {
        submissionStatus = FormzSubmissionStatus.failure;
      }
    }
  }

  void changeCurrency(dynamic value) {
    form['currencyCode'] = value;
    update();
    Get.back();
  }

  void changeName(String value) {
    nameFormz = NotEmptyFormz.dirty(value: value);
    valid = Formz.validate([nameFormz, balanceFormz]);
    form['name'] = value;
    update();
  }

  void changeBalance(String value) {
    balanceFormz = NotEmptyNumFormz.dirty(value: value);
    valid = Formz.validate([nameFormz, balanceFormz]);
    form['balance'] = value;
    update();
  }

  void changeType(String value) {
    type = value;
    update();
    if(Get.isBottomSheetOpen ?? false){
      Get.back();
    }
  }


}
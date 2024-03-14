import 'package:formz/formz.dart';
import 'package:get/get.dart';
import '../../../core/commons/form/not_empty_formz.dart';
import '../../../core/commons/form/not_empty_num_formz.dart';
import '/app/modules/accounts/controllers/accounts_controller.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';

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

  void submit() async {

  }

  void changeType(String type) {
    type = type;
    update();
    if(Get.isBottomSheetOpen ?? false){
      Get.back();
    }
  }


}
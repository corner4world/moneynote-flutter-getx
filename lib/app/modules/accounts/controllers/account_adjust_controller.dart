import 'package:get/get.dart';
import 'package:formz/formz.dart';

import '../../../core/commons/form/not_empty_formz.dart';
import '../../../core/commons/form/not_empty_num_formz.dart';
import '../../login/controllers/auth_controller.dart';
import '/app/core/base/base_controller.dart';

class AccountAdjustController extends BaseController {

  bool valid = false;
  FormzSubmissionStatus submissionStatus = FormzSubmissionStatus.initial;
  Map<String, dynamic> form = { };
  dynamic book;

  int action;
  Map<String, dynamic> currentRow;

  AccountAdjustController(this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    book = Get.find<AuthController>().initState['book'];
  }

}
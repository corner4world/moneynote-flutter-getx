import 'package:formz/formz.dart';
import 'package:get/get.dart';
import '/app/core/commons/form/not_empty_formz.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '../../login/controllers/auth_controller.dart';
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

  @override
  void onInit() {
    super.onInit();
    form['currencyCode'] = Get.find<AuthController>().initState['group']['defaultCurrencyCode'];
  }

  void submit() async {

  }

  void changeCurrency(dynamic value) {
    form['currencyCode'] = value;
    update();
    Get.back();
  }

  void changeType(String value) {
    type = value;
    update();
    if(Get.isBottomSheetOpen ?? false){
      Get.back();
    }
  }


}
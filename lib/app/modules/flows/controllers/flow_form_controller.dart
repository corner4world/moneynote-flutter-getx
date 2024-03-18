import 'package:formz/formz.dart';
import '/app/core/base/base_controller.dart';

class FlowFormController extends BaseController {

  bool valid = false;
  Map<String, dynamic> form = { };

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

    }
    if (action == 1) {

    }

  }

  void submit() async {

  }

}
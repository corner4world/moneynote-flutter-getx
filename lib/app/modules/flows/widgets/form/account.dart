import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/app/modules/common/select/select_option.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class Account extends StatelessWidget {

  final FlowFormController controller;

  const Account({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      label: LocaleKeys.flow_account.tr,
      value: controller.form['account'],
      onFocus: () {
        Get.find<SelectController>().load('accounts');
        Get.to(() => SelectOption(
          title: LocaleKeys.menu_account.tr,
          value: controller.form['account'],
          onSelect: (value) {
            controller.form['account'] = value;
            controller.update();
            Get.back();
          },
        ));
      },
    );
  }

}
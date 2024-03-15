import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_option.dart';
import 'account_select_controller.dart';

class AccountOption extends StatelessWidget {

  final dynamic value;
  final Function onSelect;

  const AccountOption({
    super.key,
    this.value = const { },
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountSelectController>(builder: (controller) {
      return MyOption(
        status: controller.status,
        options: controller.options,
        value: value,
        onSelect: onSelect,
        pageTitle: LocaleKeys.menu_account.tr,
      );
    });
  }

}
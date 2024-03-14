import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/common/currency_select/currency_select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_option.dart';

class CurrencyOption extends StatelessWidget {

  final dynamic value;
  final Function onSelect;

  const CurrencyOption({
    super.key,
    this.value = const { },
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencySelectController>(builder: (controller) {
      return MyOption(
        status: controller.status,
        options: controller.options,
        value: value,
        onSelect: onSelect,
        pageTitle: LocaleKeys.account_detailLabelCurrency.tr,
      );
    });
  }

}
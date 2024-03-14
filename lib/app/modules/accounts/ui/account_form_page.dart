import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/core/components/bottomsheet_container.dart';
import 'package:moneynote/app/core/components/form/my_select.dart';
import 'package:moneynote/app/core/utils/utils.dart';
import 'package:moneynote/app/modules/common/currency_select/currency_option.dart';
import '../../common/currency_select/currency_select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/my_form_page.dart';
import '../controllers/account_form_controller.dart';

class AccountFormPage extends StatelessWidget {

  const AccountFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountFormController>(builder: (controller) {
      return MyFormPage(
          title: Text(controller.action == 1 ? LocaleKeys.account_new.tr : LocaleKeys.account_edit.tr),
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: controller.valid ? () {
                Get.find<AccountFormController>().submit();
              } : null,
            ),
          ],
          children: [
            MySelect(
              label: LocaleKeys.account_detailLabelTypeName.tr,
              required: true,
              value: {
                'value': controller.type,
                'label': accountTypeToName(controller.type)
              },
              onFocus: () {
                Get.bottomSheet(
                  BottomSheetContainer(
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text(LocaleKeys.account_checking.tr),
                          onTap: () => Get.find<AccountFormController>().changeType('CHECKING'),
                          selected: controller.type == 'CHECKING',
                        ),
                        ListTile(
                          title: Text(LocaleKeys.account_credit.tr),
                          onTap: () => Get.find<AccountFormController>().changeType('CREDIT'),
                          selected: controller.type == 'CREDIT',
                        ),
                        ListTile(
                          title: Text(LocaleKeys.account_asset.tr),
                          onTap: () => Get.find<AccountFormController>().changeType('ASSET'),
                          selected: controller.type == 'ASSET',
                        ),
                        ListTile(
                          title: Text(LocaleKeys.account_debt.tr),
                          onTap: () => Get.find<AccountFormController>().changeType('DEBT'),
                          selected: controller.type == 'DEBT',
                        ),
                      ]
                    )
                  )
                );
              }
            ),
            MySelect(
              label: LocaleKeys.account_detailLabelCurrency.tr,
              required: true,
              value: {
                'value': controller.form['currencyCode'],
                'label': controller.form['currencyCode']
              },
              onFocus: () {
                Get.find<CurrencySelectController>().load();
                Get.to(() => CurrencyOption(
                  value: {
                    'value': controller.form['currencyCode'],
                    'label': controller.form['currencyCode']
                  },
                  onSelect: (value) {
                    Get.find<AccountFormController>().changeCurrency(value['value']);
                  },
                ));
              },
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: controller.valid ? () {
                    Get.find<AccountFormController>().submit();
                  } : null,
                  child: Text(LocaleKeys.common_submit.tr)
              ),
            )
          ]
      );
    });
  }

}
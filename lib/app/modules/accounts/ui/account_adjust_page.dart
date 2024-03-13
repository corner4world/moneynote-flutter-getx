import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/core/components/form/my_select.dart';
import 'package:moneynote/app/modules/accounts/controllers/account_adjust_controller.dart';
import 'package:moneynote/generated/locales.g.dart';

import '../../../core/components/my_form_page.dart';
import '../../common/book_select/book_option.dart';
import '../../common/book_select/book_select_controller.dart';


class AccountAdjustPage extends StatelessWidget {

  const AccountAdjustPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountAdjustController>(builder: (controller) {
      return MyFormPage(
        title: Text(LocaleKeys.account_adjustPageTitle.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              //BlocProvider.of<AccountAdjustBloc>(context).add(AdjustSubmitted());
            },
          ),
        ],
        children: [
          MySelect(
            label: LocaleKeys.book_whichBook.tr,
            required: true,
            value: controller.book,
            onFocus: () {
              Get.find<BookSelectController>().load();
              Get.to(() => BookOption(
                value: controller.book,
                onSelect: (value) {
                  controller.book = value;
                  controller.update();
                  Get.back();
                },
              ));
            },
          )
        ]
      );
    });
  }

}


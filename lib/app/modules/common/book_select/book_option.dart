import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/generated/locales.g.dart';
import '/app/modules/common/book_select/book_select_controller.dart';
import '/app/core/components/form/my_option.dart';

class BookOption extends StatelessWidget {

  final dynamic value;
  final Function onSelect;

  const BookOption({
    super.key,
    this.value = const { },
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookSelectController>(builder: (controller) {
      return MyOption(
        status: controller.status,
        options: controller.options,
        value: value,
        onSelect: onSelect,
        pageTitle: LocaleKeys.book_whichBook.tr,
      );
    });
  }

}
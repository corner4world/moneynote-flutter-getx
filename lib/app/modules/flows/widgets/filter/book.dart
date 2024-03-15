import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '../../../common/book_select/book_option.dart';
import '../../../common/book_select/book_select_controller.dart';
import '../../controllers/flows_controller.dart';

class Book extends StatelessWidget {

  const Book({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.book_whichBook.tr,
        value: controller.query['book'],
        allowClear: true,
        onClear: () {
          controller.query['book'] = null;
          controller.update();
        },
        onFocus: () {
          Get.find<BookSelectController>().load();
          Get.to(() => BookOption(
            value: controller.query['book'],
            onSelect: (value) {
              controller.query['book'] = value;
              controller.update();
              Get.back();
            },
          ));
        },
      );
    });
  }

}
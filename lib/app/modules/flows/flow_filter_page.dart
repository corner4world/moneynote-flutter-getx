import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/flows/controllers/flows_controller.dart';
import '../common/book_select/book_option.dart';
import '../common/book_select/book_select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '/app/core/components/my_form_page.dart';

class FlowFilterPage extends StatelessWidget {

  const FlowFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MyFormPage(
        title: Text(LocaleKeys.flow_filterPageTitle.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              Get.find<FlowsController>().reload();
              Get.back();
            },
          )
        ],
        children: [
          MySelect(
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
          ),
          const SizedBox(height: 70),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.done),
              onPressed: () {
                Get.find<FlowsController>().reload();
                Get.back();
              },
              label: Text(LocaleKeys.common_submit.tr)
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  Get.find<FlowsController>().reset();
                },
                label: Text(LocaleKeys.common_reset.tr)
            ),
          )
        ]
      );
    });
  }

}
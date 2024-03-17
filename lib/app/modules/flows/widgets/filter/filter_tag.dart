import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/select/tree_select_option.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '../../../common/select/select_controller.dart';
import '../../controllers/flows_controller.dart';

class FilterTag extends StatelessWidget {

  const FilterTag({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        multiple: true,
        label: LocaleKeys.flow_tag.tr,
        value: controller.query['tags'],
        allowClear: true,
        onClear: () {
          controller.query['tags'] = null;
          controller.update();
        },
        onFocus: () {
          Map<String, dynamic> query = { };
          if (controller.query['book'] != null) {
            query['bookId'] = controller.query['book']['value'];
          }
          Get.find<SelectController>().load('tags', params: query);
          Get.to(() => TreeSelectOption(
            title: LocaleKeys.flow_tag.tr,
            values: controller.query['tags'],
            onSelect: (values) {
              controller.query['tags'] = values;
              controller.update();
              Get.back();
            },
          ));
        },
      );
    });
  }

}
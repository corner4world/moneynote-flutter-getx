import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_tree_option.dart';
import '/app/modules/common/select/select_controller.dart';

class TreeSelectOption extends StatelessWidget {

  final String title;

  const TreeSelectOption({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectController>(builder: (controller) {
      return MyTreeOption(
        pageTitle: title,
      );
    });
  }

}
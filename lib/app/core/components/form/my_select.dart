import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/values/app_text_styles.dart';
import '/generated/locales.g.dart';
import '../../utils/utils.dart';
import '../asterisk.dart';

class MySelect extends StatelessWidget {

  final String label;
  final dynamic value;
  final bool readOnly;
  final bool required;
  final bool allowClear;
  final Function? onClear;
  final Function? onFocus;
  final bool multiple;

  const MySelect({
    super.key,
    required this.label,
    this.value,
    this.readOnly = false,
    this.required = false,
    this.allowClear = false,
    this.onClear,
    this.onFocus,
    this.multiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      onTap: readOnly ? null : () {
        if (onFocus != null) {
          onFocus!.call();
        }
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (required) const Asterisk(),
          Text(
            label,
            style: readOnly ? AppTextStyle.formReadOnlyLabelStyle : AppTextStyle.formLabelStyle,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value?['label'] ?? (multiple ? LocaleKeys.form_selectPlaceholder1.tr : LocaleKeys.form_selectPlaceholder2.tr),
            style: readOnly ? AppTextStyle.formReadOnlyLabelStyle : AppTextStyle.formLabelStyle,
          ),
          const Icon(Icons.keyboard_arrow_right),
          if (allowClear && !isNullEmpty(value))
            IconButton(
              onPressed: () {
                onClear?.call();
              },
              icon: const Icon(Icons.backspace)
            )
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'popup_menu.dart';


class OrderButton extends StatelessWidget {

  const OrderButton({
    super.key,
    required this.items,
  });

  final Map<String, String> items;

  @override
  Widget build(BuildContext context) {
    return PopupMenu(
      onSelected: (selected) {

      },
      items: items,
      selected: '',
    );
  }

}
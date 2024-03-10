import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../core/components/my_form_page.dart';


class AccountAdjustPage extends StatefulWidget {

  const AccountAdjustPage({
    super.key,
    required this.action,
    required this.currentRow,
  });

  final int action;
  final Map<String, dynamic> currentRow;

  @override
  State<AccountAdjustPage> createState() => _AccountAdjustPageState();

}


class _AccountAdjustPageState extends State<AccountAdjustPage> {

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<AccountAdjustBloc>(context).add(AdjustDefaultLoaded(widget.action, widget.currentRow));
  }

  @override
  Widget build(BuildContext context) {
    return MyFormPage(
        title: const Text('调整账户余额'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              //BlocProvider.of<AccountAdjustBloc>(context).add(AdjustSubmitted());
            },
          ),
        ],
        children: [

        ]
    );
  }
}

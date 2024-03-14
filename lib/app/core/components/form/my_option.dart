import 'package:flutter/material.dart';
import '../pages/empty_page.dart';
import '../pages/error_page.dart';
import '../pages/loading_page.dart';
import '/app/core/base/enums.dart';

class MyOption extends StatelessWidget {

  final List<dynamic> options;
  final LoadDataStatus status;
  final dynamic value;
  final Function onSelect;
  final String pageTitle;

  const MyOption({
    super.key,
    this.status = LoadDataStatus.initial,
    this.options = const [],
    this.value = const { },
    required this.onSelect,
    required this.pageTitle
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageTitle),
      ),
      body: () {
        switch (status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 10,
                  children:
                  options.map((e) => ChoiceChip(
                    label: Text(
                      e['label'],
                    ),
                    selected: value?['value'] == e['value'],
                    onSelected: (bool selected) {
                      onSelect.call(e);
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                      color: value?['value'] == e['value'] ? Colors.white : Colors.black,
                    ),
                  )).toList(),
                ),
              ),
            );
          case LoadDataStatus.empty:
            return const EmptyPage();
          case LoadDataStatus.failure:
            return const ErrorPage();
        }
      }()
    );
  }

}
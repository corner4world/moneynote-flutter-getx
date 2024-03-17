import 'package:flutter/material.dart';
import '../../base/enums.dart';
import '../pages/empty_page.dart';
import '../pages/error_page.dart';
import '../pages/loading_page.dart';

class MyTreeOption extends StatelessWidget {

  final String pageTitle;
  final List<dynamic> options;
  final LoadDataStatus status;
  final List<dynamic>? values;
  final Function onSelect;

  const MyTreeOption({
    super.key,
    required this.pageTitle,
    this.status = LoadDataStatus.initial,
    this.options = const [],
    this.values = const [],
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {

            },
          ),
        ],
      ),
      body:  () {
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
                  children: options.map((e) => ChoiceChip(
                    label: Text(
                      e['label'],
                    ),
                    selected: false,
                    onSelected: (bool selected) {
                      onSelect.call(e);
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                      color: Colors.black,
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
      }(),
    );
  }



}
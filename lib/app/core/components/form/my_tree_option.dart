import 'package:flutter/material.dart';

class MyTreeOption extends StatelessWidget {

  final String pageTitle;

  const MyTreeOption({
    super.key,
    required this.pageTitle
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
      body: const Text('123'),
    );
  }



}
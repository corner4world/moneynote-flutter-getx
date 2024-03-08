import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {

  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.feedback_outlined, size: 70),
          Text('无数据', style: theme.textTheme.headlineMedium),
        ],
      ),
    );
  }
  
}
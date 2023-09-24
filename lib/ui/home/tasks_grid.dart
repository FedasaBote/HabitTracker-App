import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task_with_name_loader.dart';
import 'package:habit_tracker/ui/task/task_with_name.dart';

import '../../models/task.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisSpacing = constraints.maxWidth * 0.05;
      final taskWidth = (constraints.maxWidth - crossAxisSpacing) / 2.0;
      const aspectRatio = 0.82;
      final taskHeight = taskWidth / aspectRatio;

      final mainAxisSpacing =
          max((constraints.maxHeight - taskHeight * 3) / 2.0, 0.1);
      final taskLength = tasks.length;
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: aspectRatio,
        ),
        itemCount: taskLength,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskWithNameLoader(
            task: task,
          );
        },
      );
    });
  }
}

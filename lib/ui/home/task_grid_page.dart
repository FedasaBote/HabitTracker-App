import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/home/tasks_grid.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

import '../../models/task.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: TasksGridContents(
          tasks: tasks,
        ),
      ),
    );
  }
}

class TasksGridContents extends StatelessWidget {
  const TasksGridContents({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  final List<Task> tasks;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      child: TasksGrid(
        tasks: tasks,
      ),
    );
  }
}

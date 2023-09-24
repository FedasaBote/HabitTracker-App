import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/task.dart';
import 'package:habit_tracker/models/task_state.dart';
import 'package:habit_tracker/persistence/hive_data_store.dart';
import 'package:hive/hive.dart';

import '../ui/task/task_with_name.dart';

class TaskWithNameLoader extends ConsumerWidget {
  const TaskWithNameLoader({Key? key, required this.task});
  final Task task;

  @override
  Widget build(context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.taskStateListenable(task: task),
      builder: (context, Box<TaskState> box, _) {
        final taskState = dataStore.taskState(box, task: task);
        return TaskWithName(
          taskPreset: task,
          completed: taskState.completed,
          onCompleted: (completed) {
            dataStore.setTaskState(task: task, completed: completed);
          },
        );
      },
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/models/task_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class HiveDataStore {
  static const taskBoxName = 'tasks';
  static const tasksStateBoxName = "tasksState";

  static String tasksStateKey(String taskId) => "tasksState/$taskId";
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    await Hive.openBox<Task>(taskBoxName);
    await Hive.openBox<TaskState>(tasksStateBoxName);
  }

  Future<void> createDemoTasks(
      {required List<Task> tasks, bool force = false}) async {
    final box = Hive.isBoxOpen(taskBoxName)
        ? Hive.box<Task>(taskBoxName)
        : await Hive.openBox<Task>(taskBoxName);
    if (box.isEmpty || force) {
      await box.clear();
      await box.addAll(tasks);
    } else {
      print("Box already has ${box.length} items");
    }
  }

  ValueListenable<Box<Task>> tasksListenable() {
    return Hive.box<Task>(taskBoxName).listenable();
  }

  Future<void> setTaskState({
    required Task task,
    required bool completed,
  }) {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final taskState = TaskState(taskId: task.id, completed: completed);
    return box.put(tasksStateKey(task.id), taskState);
  }

  ValueListenable<Box<TaskState>> taskStateListenable({required Task task}) {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    return box.listenable(keys: [tasksStateKey(task.id)]);
  }

  TaskState taskState(Box<TaskState> box, {required Task task}) {
    return box.get(tasksStateKey(task.id)) ??
        TaskState(taskId: task.id, completed: false);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  return HiveDataStore();
});

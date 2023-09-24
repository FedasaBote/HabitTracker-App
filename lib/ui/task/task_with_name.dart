import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/task/animated_task.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

import '../../constants/text_styles.dart';
import '../../models/task.dart';

class TaskWithName extends StatelessWidget {
  final Task taskPreset;
  final bool completed;
  final ValueChanged<bool>? onCompleted;

  const TaskWithName({
    Key? key,
    required this.taskPreset,
    this.completed = false,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedTask(
          iconName: taskPreset.iconName,
          completed: completed,
          onCompleted: onCompleted,
        ),
        const SizedBox(height: 8),
        Text(
          taskPreset.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyles.taskName.copyWith(
            color: AppTheme.of(context).accent,
          ),
        ),
      ],
    );
  }
}

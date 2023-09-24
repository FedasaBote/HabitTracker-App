import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_assets.dart';
import 'package:habit_tracker/ui/task/task_completion_ring.dart';
import 'package:habit_tracker/ui/common_widgets.dart/centered_svg_icon.dart';
import 'package:habit_tracker/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  final String iconName;
  final bool completed;
  final ValueChanged<bool>? onCompleted;
  const AnimatedTask({
    Key? key,
    required this.iconName,
    required this.completed,
    this.onCompleted,
  }) : super(key: key);
  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  bool _showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted?.call(true);
        if (mounted)
          setState(() {
            _showCheckIcon = true;
          });
      }
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _showCheckIcon = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () {
        if (_animation.status != AnimationStatus.completed) {
          _controller.reverse();
        }
      },
      onTapDown: (_) {
        if (_animation.status != AnimationStatus.completed) {
          _controller.forward();
        } else if (!_showCheckIcon) {
          widget.onCompleted?.call(false);
          _controller.reset();
        }
      },
      onTapUp: (_) {
        if (_animation.status != AnimationStatus.completed) {
          _controller.reverse();
        }
      },
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final themeData = AppTheme.of(context);
            final progress = widget.completed ? 1.0 : _animation.value;
            final hasCompleted = progress == 1.0;
            final color =
                hasCompleted ? themeData.accentNegative : themeData.taskIcon;
            return Stack(
              children: [
                TaskCompletionRing(progress: _animation.value),
                Positioned.fill(
                  child: CenteredSvgIcon(
                    iconName: hasCompleted && _showCheckIcon
                        ? AppAssets.check
                        : widget.iconName,
                    color: color,
                  ),
                )
              ],
            );
          }),
    );
  }
}

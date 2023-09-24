import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/persistence/hive_data_store.dart';
import 'package:habit_tracker/ui/home/home_page.dart';
import '../ui/theming/app_theme.dart';
import 'constants/app_assets.dart';
import 'models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveDataStore();
  await dataStore.init();
  await dataStore.createDemoTasks(tasks: [
    Task.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
    Task.create(name: 'Walk the Dog', iconName: AppAssets.dog),
    Task.create(name: 'Do Some Coding', iconName: AppAssets.html),
    Task.create(name: 'Meditate', iconName: AppAssets.meditation),
    Task.create(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
    Task.create(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
  ], force: true);
  runApp(ProviderScope(
    overrides: [
      dataStoreProvider.overrideWith((ref) => dataStore),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}

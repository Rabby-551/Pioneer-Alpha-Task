import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pioneer_alpha_ltd_task/core/di/controller_dependency_injection.dart';
import 'package:pioneer_alpha_ltd_task/core/di/interface_dependency_injection.dart';
import 'package:pioneer_alpha_ltd_task/core/hive/adapters/github_repository_adapter.dart';
import 'package:pioneer_alpha_ltd_task/core/services/app_pigeon/app_pigeon.dart';
import 'package:pioneer_alpha_ltd_task/core/constants/api_endpoints.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/presentation/screen/home_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(GitHubRepoAdapter())
    ..registerAdapter(RepoOwnerAdapter())
    ..registerAdapter(SortPreferenceAdapter());

  await Hive.openBox('reposBox');
  await Hive.openBox('settingsBox');

  externalServiceDI();
  initInterfaces();
  initControllers();

  runApp(const MyApp());
}

void externalServiceDI() {
  Get.put<AppPigeon>(
    AppPigeon(baseUrl: ApiEndpoints.githubBaseUrl),
    permanent: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pioneer Alpha Task',
      navigatorKey: navigatorKey,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}

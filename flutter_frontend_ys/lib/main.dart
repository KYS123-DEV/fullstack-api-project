import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/core/constants/db_config.dart';
import 'package:flutter_frontend_ys/common/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + NestJS',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: AppRouter.getScreen('login_page'),
    );
  }
}

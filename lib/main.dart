import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/dependencies.dart';
import 'core/routing/router.dart';
import 'core/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: providersLocal,
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: myTheme
    );
  }
}
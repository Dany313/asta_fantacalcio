import 'package:asta_fantacalcio/service_locator.dart';
import 'package:flutter/material.dart';
import 'core/routing/router.dart';
import 'core/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MyApp());
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
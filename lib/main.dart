
import 'package:asta_fantacalcio/repositories/leagues_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// android {
//     if (project.android.hasProperty("namespace")) {
//         namespace 'dev.isar.isar_flutter_libs'
//     }
//     compileSdkVersion 30
//
//     defaultConfig {
//         minSdkVersion 16
//     }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LeaguesRepository lrepo = LeaguesRepository();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () => {
            lrepo.addLeague("prova", 500)
        }),
      ),
    );
  }
}
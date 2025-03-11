import 'package:asta_fantacalcio/repositories/giocatori_repository.dart';
import 'package:asta_fantacalcio/view_models/giocatori_view_model.dart';
import 'package:asta_fantacalcio/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final giocatoriRepository = GiocatoriRepository();
  final giocatoriViewModel = GiocatoriViewModel();
  await giocatoriViewModel.fetchGiocatori();
  runApp(
    MultiProvider(
      providers: [
        Provider<GiocatoriRepository>.value(value: giocatoriRepository),
        ChangeNotifierProvider<GiocatoriViewModel>.value(value: giocatoriViewModel),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  HomeView(),
    );
  }
}
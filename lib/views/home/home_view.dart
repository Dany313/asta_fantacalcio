
import 'package:asta_fantacalcio/views/lega/lega_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../model/league.dart';
import '../../view_models/leagues_view_model.dart';

class LeaguesView extends StatefulWidget {
  const LeaguesView({super.key, required this.viewModel});

  final LeaguesViewModel viewModel;

  @override
  State<LeaguesView> createState() => _LeaguesViewState();
}

class _LeaguesViewState extends State<LeaguesView> {


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

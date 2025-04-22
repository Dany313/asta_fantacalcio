import 'package:asta_fantacalcio/presentation/viewmodels/leagues/league_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';
import '../../widgets/add_lega_dialog.dart';


const String addLegaButtonKey = 'add-lega-button';

class LeaguesView extends StatefulWidget {
  const LeaguesView({super.key, required this.viewModel});

  final LeagueViewModel viewModel;

  @override
  State<LeaguesView> createState() => _LeaguesViewState();
}

class _LeaguesViewState extends State<LeaguesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FANTA ASTA"),
        actions: [
          IconButton(
            onPressed: () {
              widget.viewModel.clearLeagues.execute();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key(addLegaButtonKey),
        child: const Icon(Icons.add),
        onPressed: () async {
          await showAddLegaDialog(
            context,
            onAdd: (nome, budget) {
              widget.viewModel.addLeague.execute(nome, budget);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lega "$nome" aggiunta con successo')),
              );
            },
          );
        },
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: widget.viewModel.leagues.length,
            itemBuilder: (context, index) {
              final lega = widget.viewModel.leagues[index];
              return Card(
                child: ListTile(
                  title: Text(lega.nome),
                  subtitle: Text("Partecipanti: ${lega.partecipanti.length}  Budget: ${lega.maxBudget}"),
                  onTap: () => {
                   context.push(Routes.legaWithName(lega.nome)),
                  },
                  trailing: IconButton(
                    onPressed: () {
                      widget.viewModel.removeLeague.execute(lega);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
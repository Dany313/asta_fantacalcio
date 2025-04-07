import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/routes.dart';
import '../../view_models/home_view_model.dart';
import 'add_lega_dialog.dart';

const String addLegaButtonKey = 'add-lega-button';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FANTA ASTA"),
        actions: [
          IconButton(
            onPressed: () {
              widget.viewModel.clear.execute();
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
              widget.viewModel.addLega.execute(nome, budget);

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
            itemCount: widget.viewModel.leghe.length,
            itemBuilder: (context, index) {
              final lega = widget.viewModel.leghe[index];
              return Card(
                child: ListTile(
                  title: Text(lega.nome),
                  subtitle: Text("Partecipanti: ${lega.partecipanti.length}  Budget: ${lega.maxBudget}"),
                  onTap: () => {
                   context.push(Routes.legaWithName(lega.nome)),
                  },
                  trailing: IconButton(
                    onPressed: () {
                      widget.viewModel.removeLega.execute(lega);
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
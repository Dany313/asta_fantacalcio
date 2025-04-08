import 'package:asta_fantacalcio/widget/allenatore_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/lega.dart';
import '../../routing/routes.dart';
import '../../view_models/lega_view_model.dart';
import 'add_partecipante_dialog.dart';

const String addLegaButtonKey = 'add-lega-button';

class LegaView extends StatefulWidget {
  const LegaView({super.key, required this.viewModel});

  final LegaViewModel viewModel;

  @override
  State<LegaView> createState() => _LegaViewState();
}

class _LegaViewState extends State<LegaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Lega: ${widget.viewModel.nomeLega}"),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.astaWithName(widget.viewModel.nomeLega));
              // widget.viewModel.clear.execute();

            },
            icon: Icon(Icons.add_chart),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key(addLegaButtonKey),
        child: const Icon(Icons.add),
        onPressed: () async {
          await showAddPartecipanteDialog(
            context,
            onAdd: (nome) {
              widget.viewModel.addPartecipante.execute(nome);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Partecipante "$nome" aggiunto con successo')),
              );
            },
          );
        },
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: widget.viewModel.partecipanti.length,
            itemBuilder: (context, index)  {
              final partecipante = widget.viewModel.partecipanti[index];
              return Card(
                child: AllenatoreWidget(
                    partecipante: partecipante,
                    deletePartecipante: widget.viewModel.removePartecipante)
              );
            },
          );
        },
      ),
    );
  }
}


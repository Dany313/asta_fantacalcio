import 'package:flutter/material.dart';

import '../../model/lega.dart';
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
          await showAddPartecipanteDialog(
            context,
            onAdd: (nome) {
              widget.viewModel.addPartecipante.execute(nome);

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
            itemCount: widget.viewModel.partecipanti.length,
            itemBuilder: (context, index) {
              final partecipante = widget.viewModel.partecipanti[index];
              return Card(
                child: ListTile(
                  title: Text(partecipante.nome),
                  onTap: () => {},
                  trailing: IconButton(
                    onPressed: () {
                      widget.viewModel.removePartecipante.execute(partecipante.nome);
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
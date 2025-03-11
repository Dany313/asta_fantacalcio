import 'package:asta_fantacalcio/view_models/lega_view_model.dart';
import 'package:asta_fantacalcio/view_models/giocatori_view_model.dart';
import 'package:asta_fantacalcio/widget/allenatore_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/lega.dart';
import '../../model/partecipante.dart';

class LegaView extends StatelessWidget {
  final Lega lega;
  const LegaView({super.key, required this.lega});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LegaViewModel>(
      create: (_) => LegaViewModel(lega),
      child: Scaffold(
        appBar: AppBar(title: Text("Lega")),
        body: Consumer2<LegaViewModel, GiocatoriViewModel>(
          builder: (context, legaViewModel, giocatoriViewModel, child) {
            if (giocatoriViewModel.listoneGiocatori.isEmpty) {
              return Center(child: CircularProgressIndicator()); // ⚡ Mostra un loader se i dati non sono pronti
            }

            return ListView.builder(
              itemCount: legaViewModel.partecipanti.length,
              itemBuilder: (context, index) {
                final partecipante = legaViewModel.partecipanti[index];

                return AllenatoreWidget(
                  partecipante: partecipante,
                  listoneGiocatori: giocatoriViewModel.listoneGiocatori, // ✅ Ora ha i dati
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addDialog(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void _addDialog(BuildContext context) {
  final TextEditingController nomeController = TextEditingController();
  final providerLega = Provider.of<LegaViewModel>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Aggiungi Partecipante"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Annulla"),
          ),
          ElevatedButton(
            onPressed: () {
              final nome = nomeController.text.trim();

              if (nome.isNotEmpty) {
                final newPartecipante = Partecipante(
                  nome: nome,
                  MaxBudget: 500,
                  giocatori: {}, // Ora possiamo usare i giocatori
                );

                providerLega.addPartecipante(newPartecipante);
              }

              Navigator.pop(context); // Chiudi la dialog
            },
            child: Text("Aggiungi"),
          ),
        ],
      );
    },
  );
}

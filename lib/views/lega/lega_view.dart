import 'package:asta_fantacalcio/view_models/lega_view_model.dart';
import 'package:asta_fantacalcio/widget/club_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/league.dart';
import '../../model/club.dart';

class LegaView extends StatelessWidget {
  final League lega;
  const LegaView({super.key, required this.lega});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LegaViewModel>(
        create: (_) => LegaViewModel(lega),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(title: Text("Lega")),
            body: ListView.builder(
              itemCount: context.watch<LegaViewModel>().partecipanti.length,
              itemBuilder: (context, index) {
                final partecipante = context.watch<LegaViewModel>().partecipanti[index];
                return ClubWidget(club: partecipante,);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addDialog(context);
              },
              child: Icon(Icons.add),
            ),
          );
        }
    );
  }
}

void _addDialog(BuildContext context) {
  final TextEditingController nomeController = TextEditingController();
  final providerLega= Provider.of<LegaViewModel>(context, listen: false);

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
                final newPartecipante = Club(
                  managerName: nome,
                  players: {},
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
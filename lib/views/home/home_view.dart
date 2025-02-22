import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/lega.dart';
import '../../view_models/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Qui inseriamo direttamente la logica del dialog
          final TextEditingController nomeController = TextEditingController();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Aggiungi Lega"),
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
                    onPressed: () => Navigator.pop(context), // Annulla
                    child: Text("Annulla"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final nome = nomeController.text.trim();

                      if (nome.isNotEmpty) {
                        final nuovaLega = Lega(
                          nome: nome,
                          partecipanti: [],
                        );

                        // Aggiungi la lega tramite ViewModel
                        context.read<HomeViewModel>().aggiungiLega(nuovaLega);
                      }

                      Navigator.pop(context); // Chiudi il dialog
                    },
                    child: Text("Aggiungi"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Leghe")),
      body: ListView.builder(
        itemCount: context.watch<HomeViewModel>().leghe.length,
        itemBuilder: (context, index) {
          final lega = context.watch<HomeViewModel>().leghe[index];
          return ListTile(
            title: Text(lega.nome),
          );
        },
      ),
    );
  }
}

  void _addDialog(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Aggiungi Lega"),
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
                  final nuovaLega = Lega(
                    nome: nome,
                    partecipanti: [],
                  );

                  Provider.of<HomeViewModel>(context, listen: false)
                      .aggiungiLega(nuovaLega);
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


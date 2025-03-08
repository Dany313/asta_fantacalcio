
import 'package:asta_fantacalcio/views/lega/lega_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../model/lega.dart';
import '../../view_models/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
    builder: (context, child) {
      return Scaffold(
        appBar: AppBar(title: Text("Fanta Asta")),
        body: ListView.builder(
          itemCount: context.watch<HomeViewModel>().leghe.length,
          itemBuilder: (context, index) {
            final lega = context.watch<HomeViewModel>().leghe[index];
            return ListTile(
              title: Text(lega.nome),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LegaView(lega: lega,)),
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
      );
    }
    );
  }
}

  void _addDialog(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final providerHome= Provider.of<HomeViewModel>(context, listen: false);

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

                  providerHome.aggiungiLega(nuovaLega);
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


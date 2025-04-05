import 'package:flutter/material.dart';

import '../../model/lega.dart';
import '../../view_models/home_view_model.dart';

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
          // Creare controller per il campo nome
          final nomeController = TextEditingController();
          // Valore iniziale per il budget
          int selectedBudget = 500;
          // Variabile per tracciare l'errore di validazione
          String? nomeError;

          // Mostrare il dialog
          await showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Aggiungi Lega'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome Lega',
                          hintText: 'Inserisci il nome della lega',
                          errorText: nomeError,
                        ),
                        onChanged: (value) {
                          // Reset dell'errore quando l'utente digita
                          if (nomeError != null) {
                            setState(() {
                              nomeError = null;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Budget Massimo:'),
                      RadioListTile<int>(
                        title: const Text('300'),
                        value: 300,
                        groupValue: selectedBudget,
                        onChanged: (value) {
                          setState(() {
                            selectedBudget = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        title: const Text('500'),
                        value: 500,
                        groupValue: selectedBudget,
                        onChanged: (value) {
                          setState(() {
                            selectedBudget = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        title: const Text('1000'),
                        value: 1000,
                        groupValue: selectedBudget,
                        onChanged: (value) {
                          setState(() {
                            selectedBudget = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annulla'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Validare che il nome non sia vuoto
                        if (nomeController.text.trim().isEmpty) {
                          setState(() {
                            nomeError = 'Il nome della lega è obbligatorio';
                          });
                          return; // Ferma l'esecuzione se il nome è vuoto
                        }

                        final nome = nomeController.text.trim();

                        // Chiamare la funzione per aggiungere la lega
                        widget.viewModel.addLega.execute(nome, selectedBudget);

                        // Chiudere il dialog
                        Navigator.pop(context);

                        // Mostrare un feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lega "$nome" aggiunta con successo')),
                        );
                      },
                      child: const Text('Aggiungi'),
                    ),
                  ],
                );
              },
            ),
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
                  onTap: () => {},
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

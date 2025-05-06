import 'package:flutter/material.dart';
import '../../viewmodels/auction/asta_view_model.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key, required this.viewModel}) : super(key: key);

  final AstaViewModel viewModel;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  void initState() {
    super.initState();
    // Se non c'è già un manager selezionato, prendo il primo
    if (widget.viewModel.managers.isNotEmpty &&
        widget.viewModel.selectedManager.isEmpty) {
      widget.viewModel.selectManager(widget.viewModel.managers[0].nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQUADRE'),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final managers = widget.viewModel.managers;
          final selected = widget.viewModel.selectedManagerPlayerList;
          final currentManager = managers.firstWhere(
                (m) => m.nome == selected,
            orElse: () => managers.isNotEmpty ? managers[0] : throw StateError('No managers'),
          );
          final playerNames = currentManager.giocatori.keys.toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chips orizzontali
              SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: managers.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, idx) {
                    final m = managers[idx];
                    final isSel = m.nome == selected;
                    return ChoiceChip(
                      label: Text(m.nome),
                      selected: isSel,
                      onSelected: (_) {
                        widget.viewModel.selectManagerPlayerList(m.nome);
                      },
                    );
                  },
                ),
              ),
              const Divider(),

              // Lista dei giocatori del manager selezionato
              Expanded(
                child: playerNames.isEmpty
                    ? const Center(child: Text('Nessun giocatore'))
                    : ListView.builder(
                  itemCount: playerNames.length,
                  itemBuilder: (context, i) {
                    final playerName = playerNames[i];
                    return ListTile(
                      title: Text(playerName),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Imposto selectedPlayer e chiamo remove
                          widget.viewModel.removePlayer.execute(currentManager.nome, playerName);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:asta_fantacalcio/presentation/viewmodels/teams/teams_view_model.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/auction/asta_view_model.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key, required this.viewModel});

  final TeamsViewModel viewModel;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.viewModel.managerName.isNotEmpty ?
        Text(widget.viewModel.managerName) :
        Text("SQUADRE"),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chips orizzontali
              SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.viewModel.managers.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, idx) {
                    final isSel = widget.viewModel.managers.keys.elementAt(idx) == widget.viewModel.selectedManager;
                    return ChoiceChip(
                      label: Text(widget.viewModel.managers.keys.elementAt(idx)),
                      selected: isSel,
                      onSelected: (_) {
                        widget.viewModel.selectManager(widget.viewModel.managers.keys.elementAt(idx));
                      },
                    );
                  },
                ),
              ),
              const Divider(),

              // Lista dei giocatori del manager selezionato
              Expanded(
                child: widget.viewModel.playersToDisplay.isEmpty
                    ? const Center(child: Text('Nessun giocatore'))
                    : ListView.builder(
                  itemCount: widget.viewModel.playersToDisplay.length,
                  itemBuilder: (context, i) {
                    final player = widget.viewModel.playersToDisplay[i];
                    return ListTile(
                      title: Text(player.nome),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Imposto selectedPlayer e chiamo remove
                          widget.viewModel.removePlayer(widget.viewModel.selectedManager,player.nome);
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

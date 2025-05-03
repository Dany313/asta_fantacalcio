import 'package:asta_fantacalcio/presentation/widgets/role_circle.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/auction/asta_view_model.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key, required this.viewModel});

  final AstaViewModel viewModel;

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carica la lista dei giocatori all'avvio della pagina
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.searchPlayer.execute('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIOCATORI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implementazione futura per filtrare i giocatori
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return Column(
            children: [
              // Campo di ricerca
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Cerca giocatori...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        widget.viewModel.searchPlayer.execute('');
                      },
                    )
                        : null,
                  ),
                  onChanged: (value) {
                    widget.viewModel.searchPlayer.execute(value);
                    setState(() {}); // Per aggiornare l'icona di cancellazione
                  },
                ),
              ),

              // Mostra il numero di giocatori trovati
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giocatori disponibili',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                    ),
                    Text(
                      '${widget.viewModel.searchPlayerList.length} giocatori',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ],
                ),
              ),

              // Lista dei giocatori
              Expanded(
                child: widget.viewModel.searchPlayerList.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sports_soccer,
                        size: 80,
                        color: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nessun giocatore trovato',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text('Prova a modificare i criteri di ricerca'),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: widget.viewModel.searchPlayerList.length,
                  itemBuilder: (context, index) {
                    final player = widget.viewModel.searchPlayerList[index];
                    final bool isSelected = player ==
                        widget.viewModel.selectedPlayer;

                    return ListTile(
                      leading: RoleCircle(widget.viewModel.players[player]!.ruolo.toUpperCase()),
                      title: Text(
                        player,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight
                              .normal,
                        ),
                      ),
                      subtitle: Text(widget.viewModel.players[player]!.squadra),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: Theme
                          .of(context)
                          .primaryColor)
                          : null,
                      selected: isSelected,
                      selectedTileColor: Theme
                          .of(context)
                          .primaryColor
                          .withOpacity(0.1),
                      onTap: () {
                        widget.viewModel.selectPlayer(player);
                      },
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
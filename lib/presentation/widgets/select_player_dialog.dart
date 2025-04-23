import 'package:flutter/material.dart';

class SelectPlayerDialog extends StatefulWidget {
  final List<String> players;
  final String? initialPlayer;
  final Function(String searchText, String? selectedPlayer) onResult;

  const SelectPlayerDialog({
    super.key,
    required this.players,
    this.initialPlayer,
    required this.onResult,
  });

  @override
  State<SelectPlayerDialog> createState() => _SelectPlayerDialogState();
}

class _SelectPlayerDialogState extends State<SelectPlayerDialog> {
  final TextEditingController searchController = TextEditingController();
  List<String> filteredPlayers = [];
  String? selectedPlayer;

  @override
  void initState() {
    super.initState();
    selectedPlayer = widget.initialPlayer;
    if (selectedPlayer != null) {
      searchController.text = selectedPlayer!;
    }
    filteredPlayers = widget.players;
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      // Resetta la selezione quando cambia il testo di ricerca
      selectedPlayer = null;

      if (query.isEmpty) {
        filteredPlayers = widget.players;
      } else {
        filteredPlayers = widget.players
            .where((player) => player.toLowerCase().contains(query))
            .toList();
      }

      // Invia immediatamente il testo di ricerca al parent
      widget.onResult(searchController.text, selectedPlayer);
    });
  }

  void _selectPlayer(String player) {
    setState(() {
      selectedPlayer = player;
      // Non aggiorniamo il testo di ricerca qui per evitare che
      // trigger _onSearchChanged ancora
    });
    // Notifica la selezione
    widget.onResult(searchController.text, selectedPlayer);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SELEZIONA GIOCATORE',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Cerca giocatore',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Text(
              'GIOCATORI:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                width: double.maxFinite,
                child: filteredPlayers.isEmpty
                    ? const Center(
                  child: Text('Nessun giocatore trovato'),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredPlayers.length,
                  itemBuilder: (context, index) {
                    final player = filteredPlayers[index];
                    final isSelected = player == selectedPlayer;

                    return ListTile(
                      title: Text(player),
                      tileColor: isSelected ? Theme.of(context).highlightColor : null,
                      onTap: () => _selectPlayer(player),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ANNULLA'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Funzione helper per mostrare il dialog
Future<void> showSelectPlayerDialog(
    BuildContext context, {
      required List<String> players,
      String? initialPlayer,
      required Function(String searchText, String? selectedPlayer) onResult,
    }) async {
  return showDialog(
    context: context,
    builder: (context) => SelectPlayerDialog(
      players: players,
      initialPlayer: initialPlayer,
      onResult: onResult,
    ),
  );
}
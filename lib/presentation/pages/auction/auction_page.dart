import 'package:asta_fantacalcio/presentation/widgets/bet_panel.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/auction/asta_view_model.dart';
import '../../widgets/allenatore_widget.dart';
import '../../widgets/select_player_dialog.dart';
import '../../widgets/set_bet_dialog.dart';

class AstaView extends StatefulWidget {
  const AstaView({super.key, required this.viewModel});

  final AstaViewModel viewModel;

  @override
  State<AstaView> createState() => _AstaViewState();
}

class _AstaViewState extends State<AstaView> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              title: const Text("ASTA"),
              automaticallyImplyLeading: true,
              actions: [
                FilledButton(
                    onPressed: () {
                      // Logic to end the auction
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.flag),
                        SizedBox(width: 3),
                        Text("Termina"),
                      ],
                    )
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Row(
                    children: [
                      // Current bet counter with plus/minus buttons
                      Expanded(
                        flex: 4,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    widget.viewModel.setBet(-1);
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showSetBetDialog(
                                        context,
                                        initialValue: 0, // Il valore attuale della bet
                                        onConfirm: (newBet) {
                                          setState(() {
                                            widget.viewModel.setBet(newBet);
                                            // Aggiorna il valore nel viewModel se necessario
                                            // widget.viewModel.updateBet(newBet);
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      alignment: Alignment.center,
                                      child: ListenableBuilder(
                                          listenable: widget.viewModel,
                                          builder: (context, _) {
                                            return Text(
                                              widget.viewModel.currentBet.toString(),
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            );
                                          }
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    widget.viewModel.setBet(1);
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Search player button
                      // Modifica il pulsante di ricerca giocatore nell'AstaView
                      // Modifica il pulsante di ricerca giocatore nell'AstaView
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ListenableBuilder(
                            listenable: widget.viewModel,
                            builder: (context, _) {
                              // Stampa di debug per verificare il valore
                              print("Rendering button with player: ${widget.viewModel.selectedPlayer}");

                              return ElevatedButton(
                                onPressed: () {
                                  widget.viewModel.searchPlayer.execute('');
                                  showSelectPlayerDialog(
                                    context,
                                    players: widget.viewModel.searchPlayerList,
                                    initialPlayer: widget.viewModel.selectedPlayer,
                                    onResult: (searchText, selectedPlayer) {
                                      // Il viewModel dovrebbe avere un metodo per filtrare i giocatori
                                      widget.viewModel.searchPlayer.execute(searchText);

                                      // Se viene selezionato un giocatore, aggiorna il viewModel
                                      if (selectedPlayer != null) {
                                        print("selezionato: $selectedPlayer");
                                        widget.viewModel.selectPlayer(selectedPlayer);
                                      }
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.search),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        widget.viewModel.selectedPlayer ?? 'Cerca giocatore',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold, // Rendilo più visibile
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Assign player button
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: ListenableBuilder(
                            listenable: widget.viewModel,
                            builder: (context, _) {
                              // Controlla se tutte le condizioni sono soddisfatte
                              final bool canAssign =
                                  widget.viewModel.currentBet > 0 &&
                                      widget.viewModel.selectedPlayer != '' &&
                                      widget.viewModel.selectedManager != '';

                              return FilledButton(
                                onPressed: canAssign
                                    ? () {
                                  widget.viewModel.addPlayer.execute();
                                }
                                    : null, // Disabilita il pulsante se non sono soddisfatte le condizioni
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Aggiudica'),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            BetPanel(),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, _) {
                  return ListView.builder(
                    itemCount: widget.viewModel.managers.length,
                    itemBuilder: (context, index) {
                      final partecipante = widget.viewModel.managers[index];
                      return GestureDetector(
                        onTap: () {
                          widget.viewModel.selectManager(partecipante.nome);

                        },
                        child: AllenatoreWidget(
                          partecipante: partecipante, isAuction: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
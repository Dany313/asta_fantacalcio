import 'package:flutter/material.dart';
import 'package:asta_fantacalcio/presentation/widgets/bet_panel.dart';
import '../../viewmodels/auction/asta_view_model.dart';
import '../../widgets/allenatore_widget.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({Key? key, required this.viewModel}) : super(key: key);

  final AstaViewModel viewModel;

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASTA'),
        actions: [
          FilledButton(
            onPressed: () {
              // Logic to end the auction
            },
            child: const Row(
              children: [Icon(Icons.flag), SizedBox(width: 3), Text('Termina')],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Card con info giocatore selezionato
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Dati del giocatore: ruolo, nome, squadra
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.viewModel.players[widget.viewModel.selectedPlayer]?.ruolo ?? '-',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.viewModel.players[widget.viewModel.selectedPlayer]?.nome ?? '-',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.viewModel.players[widget.viewModel.selectedPlayer]?.squadra ?? '-',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    // Pulsante in alto a destra
                    IconButton(
                      onPressed: () {
                        widget.viewModel.clearAuction();
                      },
                      icon: const Icon(Icons.close, size: 20),
                    ),
                    // Pulsante "Aggiudica"
                    ListenableBuilder(
                      listenable: widget.viewModel,
                      builder: (context, _) {
                        return FilledButton(
                          onPressed: (widget.viewModel.currentBet > 0 &&
                              widget.viewModel.selectedPlayer.isNotEmpty &&
                              widget.viewModel.selectedManager.isNotEmpty)
                              ? () {
                            widget.viewModel.addPlayer.execute();
                          }
                              : null,
                          child: const Text('Aggiudica'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // BetPanel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                return BetPanel(
                  bet: widget.viewModel.currentBet,
                  onBetChanged: (value) => widget.viewModel.setBet(value),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Lista manager scrollabile
          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                return ListView.builder(
                  itemCount: widget.viewModel.managers.length,
                  itemBuilder: (context, index) {
                    final manager = widget.viewModel.managers[index];
                    final isSelected = widget.viewModel.selectedManager == manager.nome;
                    final canBuy = widget.viewModel.canManagerBuy(index);
                    return GestureDetector(
                      onTap: canBuy ? () => widget.viewModel.selectManager(manager.nome) : null,
                      child: Opacity(
                        opacity: canBuy ? 1.0 : 0.5,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.green : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: AllenatoreWidget(
                            partecipante: manager,
                            isAuction: true,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

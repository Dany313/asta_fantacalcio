import 'package:flutter/material.dart';
import 'package:asta_fantacalcio/presentation/widgets/auction_panel.dart';
import '../../../domain/entities/player.dart';
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
            onPressed: (){},
            child: const Row(
              children: [Icon(Icons.flag), SizedBox(width: 3), Text('Termina')],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // AuctionPanel sempre visibile, con placeholder quando nessun giocatore selezionato
          ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              final selectedKey = widget.viewModel.selectedPlayer;
              final Player player = widget.viewModel.players[selectedKey] ??
                  Player(id: 0, nome: '-', squadra: '-', ruolo: '-', quotAttuale: 0);
              return AuctionPanel(
                player: player,
                bet: widget.viewModel.currentBet,
                onBetChanged: widget.viewModel.setBet,
                clearAuction: widget.viewModel.clearAuction,
                onAggiudica: widget.viewModel.addPlayer,
                canAggiudica: widget.viewModel.currentBet > 0 &&
                    widget.viewModel.selectedPlayer.isNotEmpty &&
                    widget.viewModel.selectedManager.isNotEmpty,
              );
            },
          ),

          const SizedBox(height: 8),

          // Lista manager scrollabile
          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                return ListView.builder(
                  itemCount: widget.viewModel.league.partecipanti.length,
                  itemBuilder: (context, index) {
                    final manager = widget.viewModel.league.partecipanti[index];
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

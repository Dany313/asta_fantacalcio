import 'package:flutter/material.dart';
import 'package:asta_fantacalcio/presentation/widgets/bet_panel.dart';
import 'package:asta_fantacalcio/presentation/widgets/role_circle.dart';
import '../../domain/entities/player.dart';

class AuctionPanel extends StatelessWidget {
  final Player player;
  final int bet;
  final ValueChanged<int> onBetChanged;
  final VoidCallback clearAuction;
  final VoidCallback onAggiudica;
  final bool canAggiudica;

  const AuctionPanel({
    super.key,
    required this.player,
    required this.bet,
    required this.onBetChanged,
    required this.clearAuction,
    required this.onAggiudica,
    required this.canAggiudica,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card con info giocatore selezionato
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: const Color.fromARGB(50, 0, 0, 153),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              tileColor: const Color.fromARGB(50, 0, 0, 153),
              // Title: ruolo e nome
              title: Row(
                children: [
                  RoleCircle(player.ruolo),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      player.nome,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              // Subtitle: squadra
              subtitle: Text(
                player.squadra,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: clearAuction,
                    icon: const Icon(Icons.close, size: 20, color: Colors.white),
                  ),
                  FilledButton(
                    onPressed: canAggiudica ? onAggiudica : null,
                    child: const Text('Aggiudica'),
                  ),
                ],
              ),
            ),
          ),
        ),

        // BetPanel
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BetPanel(
            bet: bet,
            onBetChanged: onBetChanged,
          ),
        ),
      ],
    );
  }
}

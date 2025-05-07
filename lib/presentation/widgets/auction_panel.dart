import 'package:flutter/material.dart';
import 'package:asta_fantacalcio/presentation/widgets/bet_panel.dart';
import 'package:asta_fantacalcio/presentation/widgets/role_circle.dart';
import '../../domain/entities/player.dart';

class AuctionPanel extends StatelessWidget {
  final Player player;
  final int bet;
  final ValueChanged<int> onBetChanged;
  final VoidCallback clearAuction;

  const AuctionPanel({
    super.key,
    required this.player,
    required this.bet,
    required this.onBetChanged,
    required this.clearAuction,
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
                  player.ruolo != '' ? RoleCircle(player.ruolo) : Text("SELEZIONA GIOCATORE"),
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
              trailing: IconButton(
                onPressed: clearAuction,
                iconSize: 16, // dimensione dell’icona interna, a piacere
                style: ButtonStyle(
                  // dimensione fissa del bottone
                  fixedSize: WidgetStateProperty.all(Size(32, 32)),
                  // oppure, se usi una versione di Flutter più vecchia:
                  // minimumSize: MaterialStateProperty.all(Size(32, 32)),
                  backgroundColor: WidgetStateProperty.all(Color(0xFF4200CC)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  padding: WidgetStateProperty.all(EdgeInsets.zero), // rimuove padding interno
                ),
                icon: Icon(Icons.delete_outline_rounded),
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
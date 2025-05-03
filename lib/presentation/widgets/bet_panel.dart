import 'package:flutter/material.dart';

class BetPanel extends StatelessWidget {
  final int bet;
  final ValueChanged<int> onBetChanged;

  const BetPanel({
    super.key,
    required this.bet,
    required this.onBetChanged,
  });

  // Lista dei valori per i pulsanti
  static const List<int> _steps = [-1, 1, 5, 10, -10];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCA5AFF), Color(0xFF642DD3)],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostra la puntata corrente come testo
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Puntata',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  bet.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            const VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 20,
              indent: 8,
              endIndent: 8,
            ),
            // Pulsanti generati da lista
            ..._steps.map((step) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: TextButton(
                  onPressed: () => onBetChanged(step),
                  style: TextButton.styleFrom(
                    shape: const CircleBorder(),
                    fixedSize: const Size(32, 32),
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: const Color.fromRGBO(50, 0, 153, 1),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    step > 0 ? '+$step' : '$step',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

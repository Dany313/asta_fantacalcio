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
    // Ottieni la larghezza dello schermo
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCA5AFF), Color(0xFF642DD3)],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: screenWidth < 360
          ? _buildCompactLayout()
          : _buildStandardLayout(),
    );
  }

  Widget _buildStandardLayout() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            width: 16,
            indent: 8,
            endIndent: 8,
          ),
          // Pulsanti generati da lista
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _steps.map((step) {
                return SizedBox(
                  width: 32,
                  height: 32,
                  child: TextButton(
                    onPressed: () => onBetChanged(step),
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: const Color.fromRGBO(50, 0, 153, 1),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      step > 0 ? '+$step' : '$step',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Prima riga: puntata corrente
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Puntata: ',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              bet.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Seconda riga: pulsanti
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _steps.map((step) {
            return SizedBox(
              width: 30,
              height: 30,
              child: TextButton(
                onPressed: () => onBetChanged(step),
                style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: const Color.fromRGBO(50, 0, 153, 1),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  step > 0 ? '+$step' : '$step',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
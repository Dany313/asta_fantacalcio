import 'package:flutter/material.dart';
import '../../../../core/utils/command.dart';
import '../../domain/entities/managers_entities.dart';

class AllenatoreWidget extends StatelessWidget {
  final Manager partecipante;
  final Command1<void, String>? deletePartecipante;

  const AllenatoreWidget({
    super.key,
    required this.partecipante,
    this.deletePartecipante,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: () {
         deletePartecipante != null ? deletePartecipante?.execute(partecipante.nome) : "";
        },
        icon: Icon(Icons.close),
      ),
      titleTextStyle: TextStyle(
        fontSize: 25,
      ),
      title: Text(partecipante.nome),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // P
          _buildCircleColumn(
            label: 'P',
            value: partecipante.numP.toString(),
            color: Colors.orange,
          ),
          // D
          _buildCircleColumn(
            label: 'D',
            value: partecipante.numD.toString(),
            color: Colors.green,
          ),
          // C
          _buildCircleColumn(
            label: 'C',
            value: partecipante.numC.toString(),
            color: Colors.blue,
          ),
          // A
          _buildCircleColumn(
            label: 'A',
            value: partecipante.numA.toString(),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  // Metodo di supporto per costruire il circolo colorato + testo
  Widget _buildCircleColumn({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          spacing: 5,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: color,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(value),
          ],
        ),
      ],
    );
  }
}

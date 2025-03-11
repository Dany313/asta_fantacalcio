import 'package:asta_fantacalcio/model/giocatore.dart';
import 'package:asta_fantacalcio/model/partecipante.dart';
import 'package:asta_fantacalcio/view_models/partecipante_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllenatoreWidget extends StatelessWidget {
  final Partecipante partecipante;

  const AllenatoreWidget({super.key, required this.partecipante});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PartecipanteViewModel>(
      create: (_) => PartecipanteViewModel(partecipante),
      builder: (context, child) {
        return Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nome Fantallenatore
              Text(
                context.watch<PartecipanteViewModel>().partecipante.nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Sezione con P, D, C, A e TOT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // P
                  _buildCircleColumn(
                    label: 'P',
                    value: context.watch<PartecipanteViewModel>().numPor.toString(),
                    color: Colors.orange,
                  ),
                  // D
                  _buildCircleColumn(
                    label: 'D',
                    value: context.watch<PartecipanteViewModel>().numDif.toString(),
                    color: Colors.green,
                  ),
                  // C
                  _buildCircleColumn(
                    label: 'C',
                    value: context.watch<PartecipanteViewModel>().numCC.toString(),
                    color: Colors.blue,
                  ),
                  // A
                  _buildCircleColumn(
                    label: 'A',
                    value: context.watch<PartecipanteViewModel>().numAtt.toString(),
                    color: Colors.red,
                  ),
                  // TOT
                  Column(
                    children: [
                      const Text(
                        'TOT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('0'),
                    ],
                  ),
                ],
              ),


              // Sezione Budget e Max
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('BUDGET ${context.watch<PartecipanteViewModel>().budget}'),
                  Text('MAX ${context.watch<PartecipanteViewModel>().puntataMax}'),
                ],
              ),
            ],
          ),
        );
      }
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
        CircleAvatar(
          backgroundColor: color,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/utils/command.dart';
import '../../domain/entities/Manager.dart';
import 'ManagerRecap.dart';
import 'circular_delete_button.dart';

class AllenatoreWidget extends StatelessWidget {
  final Manager partecipante;
  final bool isAuction;
  final Command1<void, String>? deletePartecipante;

  const AllenatoreWidget({
    super.key,
    required this.partecipante,
    this.deletePartecipante, required this.isAuction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(0, 50, 0, 153),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(partecipante.nome,
              textAlign: TextAlign.center,
              style:
            TextStyle(
              color: Colors.white,
              fontSize: 30
            ),),
            if(!isAuction)
            CircularDeleteButton()
          ],
        ),
        subtitle: ManagerRecap(manager: partecipante, budget: "500", maxBet: "476"),
        onTap: () {},
      ),
    );
  }
}

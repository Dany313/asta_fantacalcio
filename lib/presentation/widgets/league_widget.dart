import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/routes.dart';
import '../../core/utils/command.dart';
import '../../domain/entities/league.dart';
import 'circular_delete_button.dart';


class LeagueWidget extends StatelessWidget {
  final League league;
  final Command1<void, String>? deleteLeague;
  const LeagueWidget({super.key,required this.league,
    this.deleteLeague});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(0, 50, 0, 153),
      child: ListTile(
        onTap: () => {
          context.push(Routes.legaWithName(league.nome)),
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(league.nome,
              textAlign: TextAlign.center,
              style:
              TextStyle(
                  color: Colors.white,
                  fontSize: 30
              ),),
              CircularDeleteButton(delete: deleteLeague, deleteParam: league.nome,)
          ],
        ),
        subtitle: Text("Partecipanti: ${league.partecipanti.length} Budget: ${league.maxBudget}"),
      ),
    );
  }
}

import 'package:asta_fantacalcio/presentation/widgets/mini_count.dart';
import 'package:asta_fantacalcio/presentation/widgets/role_circle.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/Manager.dart';

class ManagerRecap extends StatelessWidget {
  final Manager manager;
  final String budget;
  final String maxBet;
  const ManagerRecap({super.key, required this.budget, required this.maxBet, required this.manager});

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.elliptical(25, 25)),
        ),
      child: Row(
        spacing: 50,
        children: [
          Row(
            children: [
              MiniCount(topWidget: RoleCircle("P"), bottomText: manager.numP.toString()),
              MiniCount(topWidget: RoleCircle("D"), bottomText: manager.numP.toString()),
              MiniCount(topWidget: RoleCircle("C"), bottomText: manager.numP.toString()),
              MiniCount(topWidget: RoleCircle("A"), bottomText: manager.numP.toString()),
              MiniCount(topWidget: Text("TOT"), bottomText: manager.giocatori.length.toString()),
            ],
          ),
          Row(
            children: [
              MiniCount(topWidget: Text("BUDGET"), bottomText: budget),
              MiniCount(topWidget: Text("MAX"), bottomText: maxBet),
            ],
          ),
        ],
      ),
    );
  }
}

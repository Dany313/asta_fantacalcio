import 'package:asta_fantacalcio/domain/usecases/teams/get_manager_team_usecase.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/manager.dart';
import '../../../domain/entities/player.dart';
import '../../../domain/usecases/teams/get_teams_usecase.dart';
import '../../../domain/usecases/teams/remove_player_usecase.dart';
import '../../../service_locator.dart';

class TeamsViewModel extends ChangeNotifier {
  String managerName;
  String leagueName;

  TeamsViewModel({required this.leagueName, required this.managerName}){
    _init();

  }

  Map<String, List<String>> managers = {};
  String selectedManager = '';
  List<Player> playersToDisplay = [];

  Future<void> _init() async {
    print("CARICO GIOCATORI");
    print("LEGA ");
    try {
      final result = await serviceLocator<GetTeamsUseCase>().call(
        leagueName,
        managerName,
      );
      result.fold((error) => print(error), (managers) {
        if (managerName.isNotEmpty) {
          for (Manager m in managers) {
            if (m.nome == managerName) {
              this.managers = {managerName: m.giocatori.keys.toList()};
            }
          }
        } else {
          for (Manager m in managers) {
            this.managers[m.nome] = m.giocatori.keys.toList();
          }
        }
        selectedManager = this.managers.keys.first;
        _getTeam(selectedManager);
      });
    } finally {
      notifyListeners();
    }
  }

  void selectManager(String newManagerName) {
    selectedManager = newManagerName;
    _getTeam(selectedManager);
    notifyListeners();
  }

  Future<void> _getTeam(String name) async {

    try {
      final result = await serviceLocator<GetManagerTeamUseCase>().call(managers[name]!);
      result.fold(
              (error) => print(error),
              (players) => playersToDisplay = players
      );
    } finally {
      notifyListeners();
    }

  }

  Future<void> removePlayer(String managerName, String player) async {
    try {
      final result = await serviceLocator<RemovePlayerUseCase>().call(leagueName, managerName, player);
      result.fold(
            (error) => print(error),
            (success) => print(success),
      );

      print("Ricaricamento leghe dopo remove...");
     await  _init();
      selectManager(managerName);
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}

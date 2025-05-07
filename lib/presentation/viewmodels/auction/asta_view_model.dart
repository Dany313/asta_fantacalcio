import 'package:asta_fantacalcio/domain/entities/league.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/get_league_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/get_players_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/command.dart';

import '../../../domain/entities/manager.dart';
import '../../../domain/entities/player.dart';
import '../../../domain/usecases/auction/add_player_usecase.dart';
import '../../../service_locator.dart';

class AstaViewModel extends ChangeNotifier {
  AstaViewModel({required this.leagueName}) {
    _initAuction();
  }

  late String leagueName;

  List<String> filteredPlayersList = [];
  Map<String, Player> players = {};
  late League league;

  String selectedPlayer = '';
  String selectedManager = '';
  int currentBet = 0;

  void selectPlayer(String player) {
    print("toggle player $player");
    if (selectedPlayer != player) {
      selectedPlayer = player;
    } else {
      selectedPlayer = '';
    }
    notifyListeners();
  }

  void setBet(int step) {
    int newBet = currentBet + step;
    if (newBet < 0) newBet = 0;
    currentBet = newBet;
    notifyListeners();
  }

  void selectManager(String managerName) {
    print("toggle manager $managerName");
    if (selectedManager != managerName) {
      selectedManager = managerName;
    } else {
      selectedManager = '';
    }
    notifyListeners();
  }
  
  Future<void> refreshLeague() async {
    try {
      print("Caricamento asta...");
      final resultLeague = await serviceLocator<GetLeagueUseCase>().call(
        leagueName,
      );
      resultLeague.fold(
            (error) => print(error),
            (league) => this.league = league,
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> _initAuction() async {
    try {
      print("Caricamento asta...");
      final resultLeague = await serviceLocator<GetLeagueUseCase>().call(
        leagueName,
      );
      resultLeague.fold(
        (error) => print(error),
        (league) => this.league = league,
      );
      final resultPlayers = await serviceLocator<GetPlayersUseCase>().call();
      resultPlayers.fold(
        (error) => print(error),
        (players) => this.players = players,
      );
      selectedPlayer = '';
      selectedManager = '';
      currentBet = 0;
      filterPlayers('');
    } finally {
      notifyListeners();
    }
  }

  Future<void> filterPlayers(String playerName) async {
    filteredPlayersList = players.keys.toList();
    for (final manager in league.partecipanti) {
      for (final player in manager.giocatori.keys) {
        filteredPlayersList.removeWhere((el) => el == player);
      }
    }
    if(playerName != '') {
      filteredPlayersList = players.keys.where(
                (player) => player.toUpperCase().contains(playerName.toUpperCase()),)
          .toList();}
    notifyListeners();
  }

  bool canManagerBuy(index) {
    if (league.partecipanti.isEmpty) {
      return false;
    }

    if (currentBet >
        league.partecipanti[index].budget - (25 - league.partecipanti[index].giocatori.length)) {
      print("prezzo superiore al budget");
      return false;
    }

    if (league.partecipanti[index].giocatori.length >= 25) {
      print("numero giocatori massimo raggiunto");
      return false;
    }

    if (selectedPlayer != '') {
      switch (players[selectedPlayer]?.ruolo) {
        case 'P':
          if (league.partecipanti[index].numP >= 3) {
            return false;
          }
          break;
        case 'D':
          if (league.partecipanti[index].numD >= 8) {
            return false;
          }
          break;
        case 'C':
          if (league.partecipanti[index].numC >= 8) {
            return false;
          }
          break;
        case 'A':
          if (league.partecipanti[index].numA >= 6) {
            return false;
          }
          break;
      }
    }

    return true;
  }

  void clearAuction() {
    currentBet = 0;
    selectedPlayer = '';
    selectedManager = '';
    notifyListeners();
  }

  Future<void> addPlayer() async {
    try {
      final result = await serviceLocator<AddPlayerUseCase>().call(
        leagueName,
        selectedManager,
        selectedPlayer,
        currentBet,
      );
      result.fold((error) => print(error), (success) {
        print(success);
        _initAuction();
      });
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}

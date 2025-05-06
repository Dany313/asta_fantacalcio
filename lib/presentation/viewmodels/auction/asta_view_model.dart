
import 'package:asta_fantacalcio/domain/entities/league.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/get_league_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/get_players_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/command.dart';

import '../../../domain/entities/manager.dart';
import '../../../domain/entities/player.dart';
import '../../../domain/usecases/auction/add_player_usecase.dart';
import '../../../domain/usecases/teams/remove_player_usecase.dart';
import '../../../service_locator.dart';

class AstaViewModel extends ChangeNotifier {
  AstaViewModel({required this.leagueName}){
    initAuction = Command0(_initAuction)..execute();
    addPlayer = Command0(_addPlayer);
    searchPlayer = Command1(_searchPlayer);
  }

  late String leagueName;



  late final Command0 initAuction;
  late Command0 addPlayer;
  late Command1<void, String> searchPlayer;

  List<String> searchPlayerList = [];
  List<Manager> managers = [];
  Map<String, Player> players = {};
  late League league;

  String selectedManagerPlayerList = '';

  String selectedPlayer = '';
  String selectedManager = '';
  int currentBet = 0;

  void selectPlayer(String player) {
    selectedPlayer = player;
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
    if(selectedManager != managerName){
      selectedManager = managerName;
    }else{
      selectedManager = '';
    }
    notifyListeners();

  }

  void selectManagerPlayerList(String managerName) {
    selectedManagerPlayerList = managerName;
    notifyListeners();
  }

  Future<void> _initAuction() async {
    try {
      print("Caricamento asta...");
      final resultLeague = await serviceLocator<GetLeagueUseCase>().call(leagueName);
      resultLeague.fold(
            (error) => print(error),
            (league) => this.league = league,
      );
      final resultPlayers = await serviceLocator<GetPlayersUseCase>().call();
      resultPlayers.fold(
            (error) => print(error),
            (players) => this.players = players,
      );

      _filterPlayerList();
      searchPlayerList = players.keys.toList();
      managers = league.partecipanti;
      selectedManagerPlayerList = managers[0].nome;
    } finally {
      notifyListeners();
    }
  }

  void _filterPlayerList() {
    for (final manager in league.partecipanti) {
      for (final player in manager.giocatori.keys) {
        players.remove(player);
      }
    }
  }





  Future<void> _searchPlayer(String playerName)  async {
    try {
      searchPlayerList = players.keys.where(
              (player) => player.toUpperCase().contains(playerName.toUpperCase()))
      .toList();

    } finally {
      notifyListeners();
    }
  }

  bool canManagerBuy(index) {

    if(currentBet > managers[index].budget - (25 - managers[index].giocatori.length)){
      print("prezzo superiore al budget");
      return false;
    }

    if(managers[index].giocatori.length >= 25){
      print("numero giocatori massimo raggiunto");
      return false;
    }

    if(selectedPlayer != ''){
      switch(players[selectedPlayer]?.ruolo) {
        case 'P':  if(managers[index].numP >= 3){
          return false;
      } break;
        case 'D':  if(managers[index].numD >= 8){
          return false;
        } break;
        case 'C':  if(managers[index].numC >= 8){
          return false;
        } break;
        case 'A':  if(managers[index].numA >= 6){
          return false;
        } break;
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

  Future<void> _addPlayer() async {

    try {
      final result = await serviceLocator<AddPlayerUseCase>().call(leagueName, selectedManager, selectedPlayer, currentBet);
      result.fold(
            (error) => print(error),
            (success)  {
              print(success);
              return _initAuction();
              },
      );

    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}

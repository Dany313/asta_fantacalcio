
import 'package:flutter/cupertino.dart';

import '../../../core/utils/command.dart';

import '../../../domain/entities/Manager.dart';
import '../../../domain/usecases/auction/add_player_usecase.dart';
import '../../../domain/usecases/auction/auction_init_usecase.dart';
import '../../../domain/usecases/auction/remove_player_usecase.dart';
import '../../../domain/usecases/auction/search_player_usecase.dart';
import '../../../service_locator.dart';

class AstaViewModel extends ChangeNotifier {
  AstaViewModel({required this.leagueName}){
    initAuction = Command0(_initAuction)..execute();
    addPlayer = Command0(_addPlayer);
    removePlayer = Command0(_removePlayer);
    searchPlayer = Command1(_searchPlayer);
  }

  late String leagueName;



  late final Command0 initAuction;
  late Command0 addPlayer;
  late Command0 removePlayer;
  late Command1<void, String> searchPlayer;

  List<String> searchPlayerList = [];
  List<Manager> managers = [];

  String selectedPlayer = '';
  String selectedManager = '';
  int currentBet = 0;

  void selectPlayer(String player) {
    selectedPlayer = player;
    notifyListeners();
  }

  void setBet(int bet) {
    if(bet + currentBet >= 0){
      print("imposto puntata ${bet + currentBet}...");
      currentBet += bet;
    }
    notifyListeners();
  }

  void selectManager(String managerName) {
    if(selectedManager != managerName){
      selectedManager = managerName;
    }else{
      selectedManager = '';
    }
    notifyListeners();

  }

  Future<void> _initAuction() async {
    try {
      print("Caricamento asta...");
      final result = await serviceLocator<AuctionInitUseCase>().call(leagueName);
      result.fold(
            (error) => print(error),
            (managers) => this.managers = managers,
      );
      currentBet = 0;
      selectedPlayer = '';
      selectedManager = '';
      _searchPlayer('');
    } finally {
      notifyListeners();
    }
  }



  Future<void> _searchPlayer(String playerName)  async {
    try {
      print("Caricamento asta...");
      final result = await serviceLocator<SearchPlayerUseCase>().call(playerName);
      result.fold(
            (error) => print(error),
            (list) => searchPlayerList = list,
      );

      print("Ricaricamento leghe dopo remove...");
    } finally {
      notifyListeners();
    }
  }



  Future<void> _removePlayer() async {
    try {
      final result = await serviceLocator<RemovePlayerUseCase>().call(leagueName, selectedManager, selectedPlayer);
      result.fold(
            (error) => print(error),
            (success) => print(success),
      );

      print("Ricaricamento leghe dopo remove...");

      return _initAuction();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
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

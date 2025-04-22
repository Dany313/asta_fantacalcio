import 'package:asta_fantacalcio/feature/auction/domain/usecases/player_list_usecase.dart';
import 'package:asta_fantacalcio/feature/league/domain/entities/leagues_entities.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';

import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';

import '../../domain/entities/auction_entities.dart';
import '../../domain/usecases/add_player_usecase.dart';
import '../../domain/usecases/remove_player_usecase.dart';
import '../../domain/usecases/search_player_usecase.dart';


class AstaViewModel extends ChangeNotifier {
  AstaViewModel({
    required PlayersListUseCase playersListUseCase,
    required AddPlayerUseCase addPlayerUseCase,
    required RemovePlayerUseCase removePlayerUseCase,
    required SearchPlayerUseCase searchPlayerUseCase,
  }) : _playersListUseCase = playersListUseCase,
        _addPlayerUseCase = addPlayerUseCase,
        _searchPlayerUseCase = searchPlayerUseCase,
        _removePlayerUseCase = removePlayerUseCase {
    getPlayersList = Command0(_getPlayersList)..execute();
    clearLeagues = Command0(_clearLeagues);
    removeLeague = Command1(_removeLeague);
    addLeague = Command2(_addLeague);
  }

  final PlayersListUseCase _playersListUseCase;
  final AddPlayerUseCase _addPlayerUseCase;
  final RemovePlayerUseCase _removePlayerUseCase;
  final SearchPlayerUseCase _searchPlayerUseCase;

  late final Command0 getPlayersList;
  late Command0 clearLeagues;
  late Command1<void, League> removeLeague;
  late Command2<void, String, int> addLeague;

  Map<String, Player> _players = {};
  Map<String, Player> get players => _players;

  List<LeagueManager> _managers = [];
  List<LeagueManager> get managers => _managers;

  Future<Result<Map<String, Player>>> _getPlayersList() async {
    try {
      print("Caricamento leghe...");
      final result = await _playersListUseCase.playersList();
      switch (result) {
        case Ok<Map<String, Player>>():
          _players = result.value;
          print("Leghe caricate: ${_players.length}");
          break;
        case Error<Map<String, Player>>():
          print("Errore nel caricamento delle leghe: $result");
          return Result.error(result.error);
      }
      return Result.ok(result.value);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _removeLeague(League lega) async {
    try {
      final resultRemove = await _removeLeagueUseCase.removeLeague(lega.nome);
      switch (resultRemove) {
        case Ok<void>():
          print("Lega rimossa con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: $resultRemove");
          return Result.error(resultRemove.error);;
      }

      print("Ricaricamento leghe dopo remove...");

      return _getLeagues();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<void>> _addLeague(String nomeLega, int maxBudget) async {
    try {
      print("Aggiungendo lega: $nomeLega con budget: $maxBudget");
      final resultAdd = await _addLeagueUseCase.addLeague(nomeLega, maxBudget);
      switch (resultAdd) {
        case Ok<void>():
          print("Lega aggiunta con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: $resultAdd");
          return Result.error(resultAdd.error);
      }

      print("Ricaricamento leghe dopo aggiunta...");
      return _getLeagues();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}

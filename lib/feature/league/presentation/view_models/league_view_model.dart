import 'package:flutter/cupertino.dart';

import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/leagues_entities.dart';
import '../../domain/usecases/add_league_usecase.dart';
import '../../domain/usecases/clear_leagues_usecase.dart';
import '../../domain/usecases/leagues_usecase.dart';
import '../../domain/usecases/remove_league_usecase.dart';

class LeagueViewModel extends ChangeNotifier {
  LeagueViewModel({
    required LeaguesUseCase leaguesUseCase,
    required AddLeagueUseCase addLeagueUseCase,
    required RemoveLeagueUseCase removeLeagueUseCase,
    required ClearLeagueUseCase clearLeagueUseCase,
  }) : _leaguesUseCase = leaguesUseCase,
       _addLeagueUseCase = addLeagueUseCase,
       _clearLeagueUseCase = clearLeagueUseCase,
       _removeLeagueUseCase = removeLeagueUseCase {
    getLeagues = Command0(_getLeagues)..execute();
    clearLeagues = Command0(_clearLeagues);
    removeLeague = Command1(_removeLeague);
    addLeague = Command2(_addLeague);
  }

  final LeaguesUseCase _leaguesUseCase;
  final AddLeagueUseCase _addLeagueUseCase;
  final RemoveLeagueUseCase _removeLeagueUseCase;
  final ClearLeagueUseCase _clearLeagueUseCase;

  late final Command0 getLeagues;
  late Command0 clearLeagues;
  late Command1<void, League> removeLeague;
  late Command2<void, String, int> addLeague;

  List<League> _leagues = [];

  List<League> get leagues => _leagues;

  Future<Result<List<League>>> _getLeagues() async {
    try {
      print("Caricamento leghe...");
      final result = await _leaguesUseCase.getLeagues();
      switch (result) {
        case Ok<List<League>>():
          _leagues = result.value;
          print("Leghe caricate: ${_leagues.length}");
          break;
        case Error<List<League>>():
          print("Errore nel caricamento delle leghe: $result");
          return Result.error(result.error);
      }
      return Result.ok(result.value);
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _clearLeagues() async {
    try {
      print("Eliminando tutte le leghe...");
      final result = await _clearLeagueUseCase.clear();
      switch (result) {
        case Ok<void>():
          print("Leghe eliminate");
          break;
        case Error<void>():
          print("Errore nel caricamento delle leghe: $result");
          return Result.error(result.error);;
      }
      return _getLeagues();
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

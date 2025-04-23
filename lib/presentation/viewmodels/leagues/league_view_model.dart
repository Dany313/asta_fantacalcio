import 'package:flutter/cupertino.dart';

import '../../../core/utils/command.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/League.dart';
import '../../../domain/usecases/leagues/add_league_usecase.dart';
import '../../../domain/usecases/leagues/clear_leagues_usecase.dart';
import '../../../domain/usecases/leagues/leagues_usecase.dart';
import '../../../domain/usecases/leagues/remove_league_usecase.dart';
import '../../../service_locator.dart';


class LeagueViewModel extends ChangeNotifier {
  LeagueViewModel() {
    getLeagues = Command0(_getLeagues)..execute();
    clearLeagues = Command0(_clearLeagues);
    removeLeague = Command1(_removeLeague);
    addLeague = Command2(_addLeague);
  }

  late final Command0<void> getLeagues;
  late Command0 clearLeagues;
  late Command1<void, League> removeLeague;
  late Command2<void, String, int> addLeague;

  List<League> _leagues = [];

  List<League> get leagues => _leagues;

  Future<void> _getLeagues() async {
    try {
      print("Caricamento leghe...");
      final result = await serviceLocator<LeaguesUseCase>().call();

      result.fold(
          (error) => print(error),
          (leghe) => _leagues = leghe
      );

    } finally {
      notifyListeners();
    }
  }

  Future<void> _clearLeagues() async {
    try {
      print("Eliminando tutte le leghe...");
      final result = await serviceLocator<ClearLeagueUseCase>().call();
      result.fold(
              (error) => print(error),
              (success) => print(success),

      );
      return _getLeagues();
    } finally {
      notifyListeners();
    }
  }

  Future<void> _removeLeague(League lega) async {
    try {
      final result = await serviceLocator<RemoveLeagueUseCase>().call(lega.nome);
      result.fold(
            (error) => print(error),
            (success) => print(success),

      );
      return _getLeagues();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<void> _addLeague(String nomeLega, int maxBudget) async {
    try {
      print("Aggiungendo lega: $nomeLega con budget: $maxBudget");
      final result = await serviceLocator<AddLeagueUseCase>().call(nomeLega, maxBudget);
      result.fold(
            (error) => print(error),
            (success) => print(success),

      );
      return _getLeagues();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../domain/entities/player.dart';

abstract class LeaguesService {
  Future<Either> getLegheList();
  Future<Either> clearLegheList();
  Future<Either> getLega(String nome);
  Future<Either> addLega(String nomeLega, int maxBudget);
  Future<Either> removeLega(String nomeLega);

  Future<Either> addManagerToLeague(String nomeLega, String nomePartecipante);
  Future<Either> removeManagerFromLeague(String nomeLega, String nomePartecipante);
  Future<Either> clearManagersFromLeague(String nomeLega);
  Future<Either> getManagersFromLeague(String leagueName);

  Future<Either> addPlayerToManager(String leagueName, String managerName, String playerName, String playerRole, int price);
  Future<Either> removePlayerFromManager(String leagueName, String managerName, String playerName);
}
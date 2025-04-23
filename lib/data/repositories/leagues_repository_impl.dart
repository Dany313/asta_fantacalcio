import 'package:dartz/dartz.dart';

import '../../domain/repositories/auction_repository.dart';
import '../../domain/repositories/leghe_repository.dart';
import '../../domain/repositories/managers_repository.dart';
import '../../service_locator.dart';
import '../datasources/leagues_service.dart';


class LeaguesRepositoryImpl implements LegheRepository, ManagersRepository, AuctionRepository {
  @override
  Future<Either> addLega(String nomeLega, int maxBudget) async {
    return await serviceLocator<LeaguesService>().addLega(nomeLega, maxBudget);
  }

  @override
  Future<Either> addManagerToLeague(String nomeLega, String nomePartecipante) async {
    return await serviceLocator<LeaguesService>().addManagerToLeague(nomeLega, nomePartecipante);
  }

  @override
  Future<Either> addPlayerToManager(String leagueName, String managerName, String playerName, String playerRole, int price) async{
    return await serviceLocator<LeaguesService>().addPlayerToManager(leagueName, managerName, playerName, playerRole, price);
  }

  @override
  Future<Either> clearLegheList() async{
    return await serviceLocator<LeaguesService>().clearLegheList();
  }

  @override
  Future<Either> clearManagersFromLeague(String nomeLega) async{
    return await serviceLocator<LeaguesService>().clearManagersFromLeague(nomeLega);
  }

  @override
  Future<Either> getLega(String nome) async{
    return await serviceLocator<LeaguesService>().getLega(nome);
  }

  @override
  Future<Either> getLegheList() async{
    return await serviceLocator<LeaguesService>().getLegheList();
  }

  @override
  Future<Either> getManagersFromLeague(String leagueName) async{
    return await serviceLocator<LeaguesService>().getManagersFromLeague(leagueName);
  }

  @override
  Future<Either> removeLega(String nomeLega) async{
    return await serviceLocator<LeaguesService>().removeLega(nomeLega);
  }

  @override
  Future<Either> removeManagerFromLeague(String nomeLega, String nomePartecipante) async{
    return await serviceLocator<LeaguesService>().removeManagerFromLeague(nomeLega, nomePartecipante);
  }

  @override
  Future<Either> removePlayerFromManager(String leagueName, String managerName, String playerName) async{
    return await serviceLocator<LeaguesService>().removePlayerFromManager(leagueName, managerName, playerName);
  }


}
import 'package:dartz/dartz.dart';
import '../../domain/repositories/players_repository.dart';
import '../../service_locator.dart';
import '../datasources/players_service.dart';


class PlayersRepositoryImpl implements PlayersRepository {
  @override
  Future<Either> getPLayer(String playerName) async {
    return await serviceLocator<PlayersService>().getPLayer(playerName);
  }

  @override
  Future<Either> getPLayerRole(String playerName) async{
    return await serviceLocator<PlayersService>().getPLayerRole(playerName);
  }

  @override
  Future<Either> getPLayers() async{
    return await serviceLocator<PlayersService>().getPLayers();
  }

  @override
  Future<Either> getPlayerActualValue(String playerName) async{
    return await serviceLocator<PlayersService>().getPlayerActualValue(playerName);
  }

  @override
  Future<bool> isPlayerPresent(String playerName) async{
    return await serviceLocator<PlayersService>().isPlayerPresent(playerName);
  }

  @override
  Future<Either> searchPlayer(String substring) async{
    return await serviceLocator<PlayersService>().searchPlayer(substring);
  }

  @override
  Future<Either> getPlayersFromList(List<String> players) async {
    return await serviceLocator<PlayersService>().getPlayersFromList(players);
  }
}
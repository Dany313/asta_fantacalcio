import 'package:dartz/dartz.dart';

abstract class PlayersService {
  Future<Either> getPLayers();
  Future<Either> getPLayer(String playerName);
  Future<Either> getPLayerRole(String playerName);
  Future<Either> getPlayerActualValue(String playerName);
  Future<bool> isPlayerPresent(String playerName);
  Future<Either> searchPlayer(String substring);
  Future<Either> getPlayersFromList(List<String> players);

}
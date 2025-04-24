import 'package:dartz/dartz.dart';

abstract class PlayersRepository {
  Future<Either> getPLayers();
  Future<Either> getPLayer(String playerName);
  Future<Either> searchPlayer(String substring);
  Future<Either> getPLayerRole(String playerName);
  Future<Either> getPlayerActualValue(String playerName);
  Future<bool> isPlayerPresent(String playerName);
}
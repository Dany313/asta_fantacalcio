import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import '../../models/player_DTO.dart';
import '../players_service.dart';

class PlayersServiceJsonImpl implements PlayersService {
  final Map<String, PlayerDTO> _playersMap;

  PlayersServiceJsonImpl._(this._playersMap);

  static Future<PlayersServiceJsonImpl> create() async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List data = json.decode(response);
    final playersList = data.map((json) => PlayerDTO.fromJson(json)).toList();

    final map = {for (var dto in playersList) dto.nome: dto};

    return PlayersServiceJsonImpl._(map);
  }

  @override
  Future<Either> getPLayer(String playerName) async {
    try {
      final player = _playersMap[playerName];
      if (player == null) throw Exception("Giocatore non trovato");
      return Right(player.mapModelToEntity());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either> getPLayerRole(String playerName) async {
    try {
      final player = _playersMap[playerName];
      if (player == null) throw Exception("Giocatore non trovato");
      return Right(player.ruolo);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<bool> isPlayerPresent(String playerName) async {
    final player = _playersMap[playerName];
    return (player == null ? true : false);
  }

  @override
  Future<Either> getPlayerActualValue(String playerName) async {
    try {
      final player = _playersMap[playerName];
      if (player == null) throw Exception("Giocatore non trovato");
      return Right(player.quotAttuale);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either> getPLayers() async {
    final map = {
      for (var key in _playersMap.keys)
        key: _playersMap[key]!.mapModelToEntity(),
    };
    return Right(map);
  }

  @override
  Future<Either> searchPlayer(String substring) async {
    if (substring == '') {
      return Right(_playersMap.keys.toList());
    }

    return Right(
      _playersMap.keys
          .where(
            (element) =>
                element.toUpperCase().contains(substring.toUpperCase()),
          )
          .toList(),
    );
  }

  @override
  Future<Either> getPlayersFromList(List<String> playerNames) async {
    try {
      final players =
          playerNames.map((name) {
            final player = _playersMap[name];
            if (player == null) {
              throw Exception("Giocatore non trovato: $name");
            }
            return player.mapModelToEntity();
          }).toList();

      return Right(players);
    } catch (e) {
      return Left(
        Exception("Errore durante il recupero dei giocatori: ${e.toString()}"),
      );
    }
  }
}

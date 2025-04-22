

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/Player.dart';
import '../../domain/repositories/players_repository.dart';
import '../models/player_DTO.dart';

class GiocatoriJsonRepository implements PlayersRepository{

  @override
  Future<Result<Map<String, Player>>> getGiocatori() async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List<dynamic> data = json.decode(response);
    final giocatori = data.map((json) => Giocatore.fromJson(json)).toList();

    // Crea una mappa dove la key è il nome del giocatore
    final Map<String, Player> mapGiocatori = {
      for (var giocatore in giocatori) giocatore.nome : giocatore.mapModeltoEntity(),
    };

    // Incapsula la mappa in un oggetto Result, ad esempio usando un costruttore "success"
    return Result.ok(mapGiocatori);
  }

  @override
  Future<Result<Player>> getPlayer(String playerName) async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List<dynamic> data = json.decode(response);
    final giocatori = data.map((json) => Giocatore.fromJson(json)).toList();
    return Result.ok(
        giocatori
        .firstWhere((playerTemp) => playerTemp.nome == playerName)
            .mapModeltoEntity()
    );
  }




}
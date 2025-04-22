import 'dart:convert';
import 'dart:io';

import 'package:asta_fantacalcio/feature/auction/domain/entities/auction_entities.dart';
import 'package:asta_fantacalcio/feature/auction/domain/repositories/players_repository.dart';
import 'package:flutter/services.dart';

import '../models/player_DTO.dart';
import '../utils/result.dart';

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
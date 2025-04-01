import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import '../model/player_detail.dart';

class PlayersListRepository {

  Future<Map<String, PlayerDetail>> getPlayers() async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List<dynamic> data = json.decode(response);
    final players = data.map((json) => PlayerDetail.fromJson(json)).toList();

    // Crea una mappa dove la key è il nome del giocatore
    return { for (var player in players) player.name : player };
  }

  Future<bool> isPlayerInSerieA(String name) async {
    final players = await getPlayers();
    return players.containsKey(name);
  }


}
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../model/player.dart';

class PlayersRepository {

  Future<Map<String, Player>> getPlayers() async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List<dynamic> data = json.decode(response);
    final players = data.map((json) => Player.fromJson(json)).toList();

    // Crea una mappa dove la key è il nome del giocatore
    return { for (var player in players) player.name : player };
  }


}
import 'dart:convert';
import 'dart:io';

import 'package:asta_fantacalcio/repositories/giocatori/giocatori_repository.dart';
import 'package:flutter/services.dart';

import '../../model/giocatore.dart';

class GiocatoriJsonRepository implements GiocatoriRepository{

  Future<Map<String, Giocatore>> getGiocatori() async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List<dynamic> data = json.decode(response);
    final giocatori = data.map((json) => Giocatore.fromJson(json)).toList();

    // Crea una mappa dove la key è il nome del giocatore
    return { for (var giocatore in giocatori) giocatore.nome : giocatore };
  }


}
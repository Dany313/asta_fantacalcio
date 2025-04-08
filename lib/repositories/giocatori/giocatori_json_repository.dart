import 'dart:convert';
import 'dart:io';

import 'package:asta_fantacalcio/repositories/giocatori/giocatori_repository.dart';
import 'package:asta_fantacalcio/utils/result.dart';
import 'package:flutter/services.dart';

import '../../model/giocatore.dart';

class GiocatoriJsonRepository implements GiocatoriRepository{

  Future<Result<Map<String, Giocatore>>> getGiocatori() async {
    final String response = await rootBundle.loadString('assets/listone.json');
    final List<dynamic> data = json.decode(response);
    final giocatori = data.map((json) => Giocatore.fromJson(json)).toList();

    // Crea una mappa dove la key è il nome del giocatore
    final Map<String, Giocatore> mapGiocatori = {
      for (var giocatore in giocatori) giocatore.nome : giocatore,
    };

    // Incapsula la mappa in un oggetto Result, ad esempio usando un costruttore "success"
    return Result.ok(mapGiocatori);
  }




}
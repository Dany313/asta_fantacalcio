import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../data/model/giocatore.dart';
import '../data/model/lega.dart';

class LegheRepository {
  // Carica le leghe dal file
  Future<List<Lega>> getLeghe() async {
    final String response = await rootBundle.loadString('lib/data/leghe.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Lega.fromJson(json)).toList();
  }

  // Aggiungi una lega e salva su file
  Future<void> addLega(Lega lega) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/leghe.json');

    // Carica le leghe attuali dal file
    final String response = await file.readAsString();
    final List<dynamic> data = json.decode(response);

    // Aggiungi la nuova lega
    data.add(lega.toJson()); // Assicurati che il modello 'Lega' abbia un metodo toJson

    // Salva i dati aggiornati nel file
    await file.writeAsString(json.encode(data));
  }

  // Salva tutte le leghe nel file
  Future<void> saveLeghe(List<Lega> leghe) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/leghe.json');

    // Converte la lista di leghe in JSON e salva
    await file.writeAsString(json.encode(leghe.map((e) => e.toJson()).toList()));
  }
}

import 'package:asta_fantacalcio/model/giocatore.dart';
import 'package:asta_fantacalcio/repositories/giocatori/giocatori_repository.dart';
import 'package:flutter/material.dart';

import '../model/partecipante.dart';
import '../model/lega.dart';
import '../repositories/leghe/leghe_repository.dart';
import '../utils/command.dart';
import '../utils/result.dart';

class LegaViewModel extends ChangeNotifier {

  LegaViewModel({
    required LegheRepository legheRepository,
    required GiocatoriRepository giocatoriRepository,
    required String nomeLega  // Parametro String aggiunto
  }) : _legheRepository = legheRepository,
        _giocatoriRepository = giocatoriRepository,
        _nomeLega = nomeLega {
    load = Command0(_load)..execute();// Salviamo il parametro
    clear = Command0(_clear);
    removePartecipante = Command1(_removePartecipante);
    addPartecipante = Command1(_addPartecipante);
  }

  final LegheRepository _legheRepository;
  final GiocatoriRepository _giocatoriRepository;
  final String _nomeLega;

  List<Partecipante> _partecipanti = [];
  int _budgetLega = 500;
  Map<String,String> _giocatoriPartecipanti = {};

  List<Partecipante> get partecipanti => _partecipanti;
  int get budgetLega => _budgetLega;
  String get nomeLega => _nomeLega;
  Map<String,String> get giocatoriPartecipanti => _giocatoriPartecipanti;

  late Command0 load;
  late Command0 clear;
  late Command1<void, String> removePartecipante;
  late Command1<void, String> addPartecipante;

  void calcolaGiocatori(String nomePartecipante) {
    int numP = 0;
    int numD = 0;
    int numC = 0;
    int numA = 0;

    _partecipanti.firstWhere((partecipante) => partecipante.nome == nomePartecipante)
    .giocatori.forEach((nomeGiocatore, valoreAcquisto) async {

      final result = await _giocatoriRepository.getGiocatore(nomeGiocatore);
      switch (result) {
        case Ok<Giocatore>():
          switch (result.value.ruolo) {
            case "P" : numP++; break;
            case "D" : numD++; break;
            case "C" : numC++; break;
            case "A" : numA++; break;
          }
        case Error<Giocatore>():
          print("Errore nel caricamento della lega: ${result}");
      }
    });
    _giocatoriPartecipanti[nomePartecipante] = "P:$numP D:$numD C:$numC A:$numA";

  }

  Future<Result> _load() async {
    try {
      print("Caricamento partecipanti...");
      final result = await _legheRepository.getLega(_nomeLega);
      switch (result) {
        case Ok<Lega>():
          _budgetLega = result.value.maxBudget;
          _partecipanti = result.value.partecipanti;
          for (var partecipante in _partecipanti) {
            calcolaGiocatori(partecipante.nome);
          }
          print("Lega caricata: $_nomeLega");
        case Error<Lega>():
          print("Errore nel caricamento della lega: ${result}");
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }


  Future<Result> _clear() async {
    try {
      print("Eliminando tutte le leghe...");
      final result = await _legheRepository.clearPartecipantiFromLega(_nomeLega);
      switch (result) {
        case Ok<void>():
          _load();
        case Error<void>():
          print("Errore nel caricamento delle leghe: ${result}");
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _removePartecipante(String nomePartecipantea) async {
    try {
      final resultRemove = await _legheRepository.removePartecipanteFromLega(_nomeLega, nomePartecipantea);
      switch (resultRemove) {
        case Ok<void>():
          print("Lega rimossa con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: ${resultRemove}");
          return resultRemove;
      }

      return _load();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<void>> _addPartecipante(String nomePartecipante) async {
    try {
      print("Aggiungendo partecipante: $nomePartecipante alla lega: $_nomeLega");
      final resultAdd = await _legheRepository.addPartecipanteToLega(_nomeLega, nomePartecipante);
      switch (resultAdd) {
        case Ok<void>():
          print("Partecipante con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta del partecipante: ${resultAdd}");
          return resultAdd;
      }

      return _load();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }


}
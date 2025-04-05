
import 'package:asta_fantacalcio/repositories/giocatori/giocatori_json_repository.dart';
import 'package:flutter/cupertino.dart';


import '../repositories/leghe/leghe_json_repository.dart';
import '../model/lega.dart';
import '../repositories/leghe/leghe_repository.dart';
import '../utils/command.dart';
import '../utils/result.dart';


class HomeViewModel extends ChangeNotifier {

  HomeViewModel({
    required LegheRepository legheRepository
  }) : _legheRepository = legheRepository {
    load = Command0(_load)..execute();
    clear = Command0(_clear);
    removeLega = Command1(_removeLega);
    addLega = Command2(_addLega);
  }

  final LegheRepository _legheRepository;

  List<Lega> _leghe = [];
  List<Lega> get leghe => _leghe;

  late Command0 load;
  late Command0 clear;
  late Command1<void, Lega> removeLega;
  late Command2<void, String, int> addLega;

  Future<Result> _load() async {
    try {
      print("Caricamento leghe...");
      final result = await _legheRepository.getLegheList();
      switch (result) {
        case Ok<List<Lega>>():
          _leghe = result.value;
          print("Leghe caricate: ${_leghe.length}");
        case Error<List<Lega>>():
          print("Errore nel caricamento delle leghe: ${result}");
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
      final result = await _legheRepository.clearLegheList();
      switch (result) {
        case Ok<void>():
          _leghe = [];
          print("Leghe caricate: ${_leghe.length}");
        case Error<void>():
          print("Errore nel caricamento delle leghe: ${result}");
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _removeLega(Lega lega) async {
    try {
      final resultRemove = await _legheRepository.removeLega(lega);
      switch (resultRemove) {
        case Ok<void>():
          print("Lega rimossa con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: ${resultRemove}");
          return resultRemove;
      }

      print("Ricaricamento leghe dopo remove...");
      final resultLoadLeghe = await _legheRepository.getLegheList();
      switch (resultLoadLeghe) {
        case Ok<List<Lega>>():
          _leghe = resultLoadLeghe.value;
          print("Leghe ricaricate: ${_leghe.length}");
        case Error<List<Lega>>():
          print("Errore nel ricaricamento delle leghe: ${resultLoadLeghe}");
          return resultLoadLeghe;
      }

      return resultLoadLeghe;
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<void>> _addLega(String nomeLega, int maxBudget) async {
    try {
      print("Aggiungendo lega: $nomeLega con budget: $maxBudget");
      final resultAdd = await _legheRepository.addLega(nomeLega, maxBudget);
      switch (resultAdd) {
        case Ok<void>():
          print("Lega aggiunta con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: ${resultAdd}");
          return resultAdd;
      }

      print("Ricaricamento leghe dopo aggiunta...");
      final resultLoadLeghe = await _legheRepository.getLegheList();
      switch (resultLoadLeghe) {
        case Ok<List<Lega>>():
          _leghe = resultLoadLeghe.value;
          print("Leghe ricaricate: ${_leghe.length}");
        case Error<List<Lega>>():
          print("Errore nel ricaricamento delle leghe: ${resultLoadLeghe}");
          return resultLoadLeghe;
      }

      return resultLoadLeghe;
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  // Future<Result> _fetchLeghe() async {
  //   try {
  //     final result = await _legheRepository.load();
  //     switch (result) {
  //       case Ok<List<Lega>>():
  //         _leghe = result.value;
  //       case Error<List<Lega>>():
  //         return result;
  //     }
  //     return result;
  //   } finally {
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> aggiungiLega(Lega lega) async {
  //   _leghe.add(lega);
  //   notifyListeners();
  //   await _legheRepository.saveLeghe(_leghe);
  // }
  //
  // Future<void> rimuoviLega(Lega lega) async {
  //   _leghe.remove(lega);
  //   notifyListeners();
  //   await _legheRepository.saveLeghe(_leghe);
  // }
}
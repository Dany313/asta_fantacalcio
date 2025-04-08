import 'package:flutter/foundation.dart';
import '../model/giocatore.dart';
import '../model/lega.dart';
import '../model/partecipante.dart';
import '../repositories/giocatori/giocatori_repository.dart';
import '../repositories/leghe/leghe_repository.dart';
import '../utils/command.dart';
import '../utils/result.dart';

class AstaViewModel extends ChangeNotifier {

  AstaViewModel({
    required LegheRepository legheRepository,
    required GiocatoriRepository giocatoriRepository,
    required String nomeLega  // Parametro String aggiunto
  }) : _legheRepository = legheRepository,
        _giocatoriRepository = giocatoriRepository,
        _nomeLega = nomeLega {
    load = Command0(_load)..execute();// Salviamo il parametro

  }


  final GiocatoriRepository _giocatoriRepository;
  final LegheRepository _legheRepository;
  final String _nomeLega;

  List<Partecipante> _partecipanti = [];
  Map<String,Giocatore> _listoneGiocatori = {};
  int _budgetLega = 500;

  List<Partecipante> get partecipanti => _partecipanti;
  Map<String,Giocatore> get listoneGiocatori => _listoneGiocatori;
  int get budgetLega => _budgetLega;
  String get nomeLega => _nomeLega;

  late Command0 load;


  Future<Result> _load() async {
    try {
      print("Caricamento partecipanti...");
      final resultLega = await _legheRepository.getLega(_nomeLega);
      switch (resultLega) {
        case Ok<Lega>():
          _budgetLega = resultLega.value.maxBudget;
          _partecipanti = resultLega.value.partecipanti;
          print("Lega caricata: $_nomeLega");
        case Error<Lega>():
          print("Errore nel caricamento della lega: ${resultLega}");
          return resultLega;
      }

      print("Caricamento partecipanti...");
       final resultGiocatori = await _giocatoriRepository.getGiocatori();
      switch (resultGiocatori) {
        case Ok<Map<String,Giocatore>>():
          _listoneGiocatori = resultGiocatori.value;
          print("Lega caricata: $_nomeLega");
        case Error<Map<String,Giocatore>>():
          print("Errore nel caricamento della lega: ${resultGiocatori}");
          return resultGiocatori;
      }
      return resultGiocatori;
    } finally {
      notifyListeners();
    }
  }


}
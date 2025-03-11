
import 'package:asta_fantacalcio/model/giocatore.dart';
import 'package:asta_fantacalcio/model/partecipante.dart';
import 'package:flutter/cupertino.dart';

import '../repositories/giocatori_repository.dart';

class PartecipanteViewModel extends ChangeNotifier {
  final GiocatoriRepository _giocatoriRepository = GiocatoriRepository();

  List<Giocatore> _listGiocatori = [];
  late final Partecipante _partecipante;
  late int budget = 0;
  late int puntataMax = 0;
  late int numPor = 0;
  late int numDif = 0;
  late int numCC = 0;
  late int numAtt = 0;

  Partecipante get partecipante => _partecipante;

  PartecipanteViewModel(this._partecipante) {
    _partecipante.giocatori.addAll({'Lookman' :100});
    _partecipante.giocatori.addAll({'Pinamonti' :100});
    calcolaValori();

  }
  calcolaValori() async {
    _listGiocatori = await _giocatoriRepository.getGiocatori();
    budget = calcoloBudgetResiduo();
    puntataMax =  budget - (25 - _partecipante.giocatori.length);
    numPor = calcolaNumRuolo('P');
    numDif = calcolaNumRuolo('D');
    numCC = calcolaNumRuolo('C');
    numAtt = calcolaNumRuolo('A');
    notifyListeners();

  }


  int calcoloBudgetResiduo(){
    int tempBudget = _partecipante.MaxBudget;
    print(_partecipante.giocatori.values);
    for (int costo in _partecipante.giocatori.values) {
      tempBudget -= costo;
    }
    return tempBudget;
  }
  int calcolaNumRuolo(String ruolo) {
    return _listGiocatori.where((e) => _partecipante.giocatori.containsKey(e.nome) && e.ruolo == ruolo).toSet().length;

  }


}
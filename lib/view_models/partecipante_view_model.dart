
import 'package:asta_fantacalcio/model/giocatore.dart';
import 'package:asta_fantacalcio/model/partecipante.dart';
import 'package:flutter/cupertino.dart';

import '../repositories/giocatori_repository.dart';

class PartecipanteViewModel extends ChangeNotifier {
  final Map<String, Giocatore> _listoneGiocatori;
  late final Partecipante _partecipante;
  late int budget = 0;
  late int puntataMax = 0;
  late int numPor = 0;
  late int numDif = 0;
  late int numCC = 0;
  late int numAtt = 0;

  Partecipante get partecipante => _partecipante;

  PartecipanteViewModel(this._partecipante,this._listoneGiocatori) {
    _partecipante.giocatori.addAll({'Lookman' :100});
    _partecipante.giocatori.addAll({'Pinamonti' :100});
    _partecipante.giocatori.addAll({'Meret' :12});
    calcolaValori();
  }

  calcolaValori() {
    budget = _partecipante.MaxBudget;
    for (var nomeGiocatore in _partecipante.giocatori.keys) {
      budget -= _partecipante.giocatori[nomeGiocatore]!;
      switch(_listoneGiocatori[nomeGiocatore]?.ruolo){
        case 'P':
          numPor += 1;
          break;
        case 'D':
          numDif += 1;
          break;
        case 'C':
          numCC += 1;
          break;
        case 'A':
          numAtt += 1;
          break;
        default:
          break;
      }
    }
    puntataMax =  budget - (25 - _partecipante.giocatori.length);
    notifyListeners();
  }

}
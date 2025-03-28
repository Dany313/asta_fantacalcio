
import 'package:asta_fantacalcio/model/player.dart';
import 'package:asta_fantacalcio/model/club.dart';
import 'package:flutter/cupertino.dart';

import '../repositories/players_repository.dart';

class PartecipanteViewModel extends ChangeNotifier {
  final PlayersRepository _giocatoriRepository = PlayersRepository();
   Map<String, Player> _listoneGiocatori = {};
  late final Club _partecipante;
  late int budget = 0;
  late int puntataMax = 0;
  late int numPor = 0;
  late int numDif = 0;
  late int numCC = 0;
  late int numAtt = 0;

  Club get partecipante => _partecipante;

  PartecipanteViewModel(this._partecipante) {
    _partecipante.players.addAll({'Lookman' :100});
    _partecipante.players.addAll({'Pinamonti' :100});
    _partecipante.players.addAll({'Meret' :12});
    calcolaValori();
  }

  calcolaValori() async {
    _listoneGiocatori = await _giocatoriRepository.getPlayers();
    for (var nomeGiocatore in _partecipante.players.keys) {
      budget -= _partecipante.players[nomeGiocatore]!;
      switch(_listoneGiocatori[nomeGiocatore]?.role){
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
    puntataMax =  budget - (25 - _partecipante.players.length);
    notifyListeners();
  }

}
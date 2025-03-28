import 'package:asta_fantacalcio/model/club.dart';
import 'package:flutter/widgets.dart';

import '../model/player.dart';
import '../model/league.dart';
import '../repositories/players_repository.dart';
import '../repositories/leagues_repository.dart';

class LegaViewModel extends ChangeNotifier {

  final LeaguesRepository _legheRepository = LeaguesRepository();
  final League _lega;
  late List<Club> _partecipanti;
  late String nomeLega;

  List<Club> get partecipanti => _partecipanti;


  LegaViewModel(this._lega) {
    _partecipanti = _lega.clubs;
    nomeLega = _lega.name;
  }

  Future<void> addPartecipante(Club newPartecipante) async {
    _partecipanti.add(newPartecipante);
    notifyListeners();
    await _legheRepository.updateLeague(_lega);
  }

  Future<void> removePartecipante(Club newPartecipante) async {
    _partecipanti.remove(newPartecipante);
    notifyListeners();
    await _legheRepository.updateLeague(_lega);
  }
}
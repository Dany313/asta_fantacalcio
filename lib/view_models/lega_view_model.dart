import 'package:asta_fantacalcio/model/partecipante.dart';
import 'package:flutter/widgets.dart';

import '../model/giocatore.dart';
import '../model/lega.dart';
import '../repositories/giocatori_repository.dart';
import '../repositories/leghe_repository.dart';

class LegaViewModel extends ChangeNotifier {

  final LegheRepository _legheRepository = LegheRepository();
  final Lega _lega;
  late List<Partecipante> _partecipanti;
  late String nomeLega;

  List<Partecipante> get partecipanti => _partecipanti;


  LegaViewModel(this._lega) {
    _partecipanti = _lega.partecipanti;
    nomeLega = _lega.nome;
  }

  Future<void> addPartecipante(Partecipante newPartecipante) async {
    _partecipanti.add(newPartecipante);
    notifyListeners();
    await _legheRepository.updateLega(_lega);
  }

  Future<void> removePartecipante(Partecipante newPartecipante) async {
    _partecipanti.remove(newPartecipante);
    notifyListeners();
    await _legheRepository.updateLega(_lega);
  }
}
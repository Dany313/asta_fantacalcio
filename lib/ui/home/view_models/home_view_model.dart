import 'package:flutter/cupertino.dart';

import '../../../data/model/lega.dart';
import '../../../data/model/repositories/leghe_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final LegheRepository _repository = LegheRepository();
  List<Lega> _leghe = [];

  List<Lega> get leghe => _leghe;

  HomeViewModel() {
    fetchLeghe();
  }

  // Carica le leghe dal repository
  Future<void> fetchLeghe() async {
    _leghe = await _repository.getLeghe();
    notifyListeners();
  }

  // Aggiungi una lega e salva su file
  Future<void> aggiungiLega(Lega nuovaLega) async {
    _leghe.add(nuovaLega); // Aggiungi alla lista locale
    await _repository.addLega(nuovaLega); // Salva nel file
    print(_leghe);
    print(leghe);
    notifyListeners();
  }

  // Rimuovi una lega e salva su file
  Future<void> rimuoviLega(Lega lega) async {
    _leghe.remove(lega); // Rimuovi dalla lista locale
    await _repository.saveLeghe(_leghe); // Salva la lista aggiornata
    notifyListeners();
    fetchLeghe();
  }
}
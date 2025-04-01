
import 'package:asta_fantacalcio/repositories/giocatori_repository.dart';
import 'package:flutter/cupertino.dart';


import '../../../repositories/leghe_repository.dart';
import '../model/lega.dart';
import '../utils/command.dart';
import '../utils/result.dart';


class HomeViewModel extends ChangeNotifier {
  final LegheRepository _legheRepository = LegheRepository();
  List<Lega> _leghe = [];

  List<Lega> get leghe => _leghe;

  late Command0 load;

  HomeViewModel() {
    load = Command0(_fetchLeghe)..execute();
  }

  Future<Result> _fetchLeghe() async {
    try {
      final result = await _legheRepository.load();
      switch (result) {
        case Ok<List<Lega>>():
          _leghe = result.value;
        case Error<List<Lega>>():
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<void> aggiungiLega(Lega lega) async {
    _leghe.add(lega);
    notifyListeners();
    await _legheRepository.saveLeghe(_leghe);
  }

  Future<void> rimuoviLega(Lega lega) async {
    _leghe.remove(lega);
    notifyListeners();
    await _legheRepository.saveLeghe(_leghe);
  }
}
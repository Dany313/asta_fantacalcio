
import 'package:flutter/cupertino.dart';


import '../../../repositories/leghe_repository.dart';
import '../model/lega.dart';


class HomeViewModel extends ChangeNotifier {
  final LegheRepository _legheRepository = LegheRepository();
  List<Lega> _leghe = [];

  List<Lega> get leghe => _leghe;

  HomeViewModel() {
    fetchLeghe();
  }

  Future<void> fetchLeghe() async {
    _leghe = await _legheRepository.getLeghe();
    notifyListeners();
  }


  Future<void> aggiungiLega(Lega nuovaLega) async {
    _leghe.add(nuovaLega);
    notifyListeners();
  }


  Future<void> rimuoviLega(Lega lega) async {
    _leghe.remove(lega);
    notifyListeners();
  }
}
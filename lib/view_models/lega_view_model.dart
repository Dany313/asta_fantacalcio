import 'package:asta_fantacalcio/model/partecipante.dart';
import 'package:flutter/widgets.dart';

class LegaViewModel extends ChangeNotifier {
  List<Partecipante> _partecipanti = [];

  List<Partecipante> get partecipanti => _partecipanti;

  Future<void> addPartecipante(Partecipante newPartecipante) async {
    _partecipanti.add(newPartecipante);
    notifyListeners();
  }

  Future<void> removePartecipante(Partecipante newPartecipante) async {
    _partecipanti.remove(newPartecipante);
    notifyListeners();
  }
}
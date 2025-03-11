import 'package:flutter/material.dart';
import '../model/giocatore.dart';
import '../repositories/giocatori_repository.dart';

class GiocatoriViewModel extends ChangeNotifier {
  final GiocatoriRepository _repository = GiocatoriRepository();
  Map<String, Giocatore> _listoneGiocatori = {};
  bool _isLoading = true;
  String? _errorMessage;

  // Getter
  Map<String, Giocatore> get listoneGiocatori => _listoneGiocatori;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Costruttore
  GiocatoriViewModel() {
    fetchGiocatori();
  }

  Future<void> fetchGiocatori() async {
    _isLoading = true;
    notifyListeners();

    try {
      _listoneGiocatori = await _repository.getGiocatori();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Errore nel caricamento dei giocatori";
    }

    _isLoading = false;
    notifyListeners();
  }
}

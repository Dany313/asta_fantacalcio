import 'package:asta_fantacalcio/repositories/leghe_repository.dart';
import 'package:flutter/foundation.dart';
import '../model/giocatore.dart';
import '../model/partecipante.dart';
import '../repositories/giocatori_repository.dart'; 

class AstaViewModel extends ChangeNotifier {
  final GiocatoriRepository _giocatoriRepository = GiocatoriRepository();
  final LegheRepository _legheRepository = LegheRepository();
  Map<String, Giocatore> _tuttiGiocatori = {};
  List<Giocatore> _giocatoriFiltrati = [];
  Giocatore? _giocatoreSelezionato;
  Partecipante? _partecipanteSelezionato;
  int _valoreCorrente = 0;
  bool _isLoading = true;

  AstaViewModel() {
    _caricaGiocatori();
  }

  // Getters
  int get valoreCorrente => _valoreCorrente;
  List<Giocatore> get giocatoriFiltrati => _giocatoriFiltrati;
  Giocatore? get giocatoreSelezionato => _giocatoreSelezionato;
  Partecipante? get partecipanteSelezionato => _partecipanteSelezionato;
  bool get isLoading => _isLoading;

  // Carica tutti i giocatori dal repository
  Future<void> _caricaGiocatori() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tuttiGiocatori = await _giocatoriRepository.getGiocatori();
    } catch (e) {
      print('Errore nel caricamento dei giocatori: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cerca giocatori che contengono la stringa fornita
  void cercaGiocatori(String query) {
    if (query.isEmpty) {
      _giocatoriFiltrati = [];
    } else {
      _giocatoriFiltrati = _tuttiGiocatori.values
          .where((giocatore) =>
          giocatore.nome.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Seleziona un giocatore dalla lista filtrata
  void selezionaGiocatore(Giocatore giocatore) {
    _giocatoreSelezionato = giocatore;
    notifyListeners();
  }

  // Seleziona un partecipante dalla lista
  void selezionaPartecipante(Partecipante partecipante) {
    _partecipanteSelezionato = partecipante;
    notifyListeners();
  }

  void assegnaGiocatore(String nomeLega){
    _legheRepository.addGiocatoreToPartecipante(
        _giocatoreSelezionato!.nome,
        _valoreCorrente,
        nomeLega,
        _partecipanteSelezionato!.nome);
    notifyListeners();
  }

  void removeGiocatore(String nomeLega){
    _legheRepository.removeGiocatoreFromPartecipante(
        _giocatoreSelezionato!.nome,
        nomeLega,
        _partecipanteSelezionato!.nome);
    notifyListeners();
  }



  void incrementaValore() {
    _valoreCorrente++;
    notifyListeners();
  }

  void decrementaValore() {
    if (_valoreCorrente > 0) {
      _valoreCorrente--;
      notifyListeners();
    }
  }
}
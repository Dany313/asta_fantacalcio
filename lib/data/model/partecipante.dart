import 'giocatore.dart';

class Partecipante{
  final String nome;
  final int budget;
  final List<Giocatore> giocatori;

  Partecipante({
    required this.nome,
    required this.budget,
    required this.giocatori
  });
}
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

  factory Partecipante.fromJson(Map<String, dynamic> json) {
    return Partecipante(
      nome: json['nome'] as String,
      budget: json['budget'] as int,
      giocatori: (json['giocatori'] as List<dynamic>)
        .map((item) => Giocatore.fromJson(item))
        .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'budget': budget,
      'giocatori': giocatori.map((p) => p.toJson()).toList(),
    };
  }
}
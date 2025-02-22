import 'giocatore.dart';

class Partecipante{
  final String nome;
  final int budget;
  final Map<String,int> giocatori;

  Partecipante({
    required this.nome,
    required this.budget,
    required this.giocatori
  });

  factory Partecipante.fromJson(Map<String, dynamic> json) {
    return Partecipante(
      nome: json['nome'] as String,
      budget: json['budget'] as int,
        giocatori: (json['giocatori'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, value as int),)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'budget': budget,
      'giocatori': giocatori
    };
  }
}
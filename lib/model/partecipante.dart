import 'giocatore.dart';

class Partecipante{
  final String nome;
  final int MaxBudget;
  final Map<String,int> giocatori;

  Partecipante({
    required this.nome,
    required this.MaxBudget,
    required this.giocatori
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Partecipante) return false;
    return other.nome == nome;
  }

  @override
  int get hashCode => nome.hashCode;

  factory Partecipante.fromJson(Map<String, dynamic> json) {
    return Partecipante(
      nome: json['nome'] as String,
        MaxBudget: json['MaxBudget'] as int,
        giocatori: (json['giocatori'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, value as int),)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'MaxBudget': MaxBudget,
      'giocatori': giocatori
    };
  }
}
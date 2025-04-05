import 'partecipante.dart';

class Lega {
  final String nome;
  final int maxBudget;
  late final List<Partecipante> partecipanti;

  Lega({
    required this.nome,
    required this.maxBudget,
    required this.partecipanti
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Lega) return false;
    return other.nome == nome;
  }

  @override
  int get hashCode => nome.hashCode;

  factory Lega.fromJson(Map<String, dynamic> json) {
    return Lega(
      nome: json['nome'] as String,
      maxBudget: json['max_budget'] as int,
      partecipanti: (json['partecipanti'] as List<dynamic>)
          .map((item) => Partecipante.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'max_budget': maxBudget,
      'partecipanti': partecipanti.map((p) => p.toJson()).toList(),
    };
  }

}
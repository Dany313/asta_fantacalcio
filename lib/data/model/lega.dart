import 'partecipante.dart';

class Lega {
  final String nome;
  final List<Partecipante> partecipanti;

  Lega({
    required this.nome,
    required this.partecipanti
  });

  factory Lega.fromJson(Map<String, dynamic> json) {
    return Lega(
      nome: json['nome'] as String,
      partecipanti: (json['partecipanti'] as List<dynamic>)
          .map((item) => Partecipante.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'partecipanti': partecipanti.map((p) => p.toJson()).toList(),
    };
  }

}
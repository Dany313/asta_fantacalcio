
class Partecipante{
  final String nome;
  final int numP;
  final int numD;
  final int numC;
  final int numA;
  final Map<String,int> giocatori;

  Partecipante({
    required this.nome,
    required this.numP,
    required this.numD,
    required this.numC,
    required this.numA,
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
        numP: json['num_p'] as int,
        numD: json['num_d'] as int,
        numC: json['num_c'] as int,
        numA: json['num_a'] as int,
        giocatori: (json['giocatori'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, value as int),)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'num_p' : numP,
      'num_d' : numD,
      'num_c' : numC,
      'num_a' : numA,
      'giocatori': giocatori
    };
  }
}
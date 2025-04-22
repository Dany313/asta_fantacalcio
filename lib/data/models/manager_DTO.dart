


import '../../domain/entities/Manager.dart';

class ManagerDTO{
  final String nome;
  final int numP;
  final int numD;
  final int numC;
  final int numA;
  final Map<String,int> giocatori;

  ManagerDTO({
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
    if (other is! ManagerDTO) return false;
    return other.nome == nome;
  }

  @override
  int get hashCode => nome.hashCode;

  factory ManagerDTO.fromJson(Map<String, dynamic> json) {
    return ManagerDTO(
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

  Manager mapModeltoEntity(){
    return  Manager(nome: nome, numP: numP, numD: numD, numC: numC, numA: numA, giocatori: giocatori);
  }
}
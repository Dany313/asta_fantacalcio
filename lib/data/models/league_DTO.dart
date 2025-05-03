

import '../../domain/entities/league.dart';
import '../../domain/entities/manager.dart';
import 'manager_DTO.dart';

class LeagueDTO {
  final String nome;
  final int maxBudget;
  late final List<ManagerDTO> partecipanti;

  LeagueDTO({
    required this.nome,
    required this.maxBudget,
    required this.partecipanti
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LeagueDTO) return false;
    return other.nome == nome;
  }

  @override
  int get hashCode => nome.hashCode;

  factory LeagueDTO.fromJson(Map<String, dynamic> json) {
    return LeagueDTO(
      nome: json['nome'] as String,
      maxBudget: json['max_budget'] as int,
      partecipanti: (json['partecipanti'] as List<dynamic>)
          .map((item) => ManagerDTO.fromJson(item))
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
  
  League mapModelToEntity(){
    List<Manager> tempList = [];
    for(ManagerDTO p in partecipanti) {
      final totalPlayerCost =
      p.giocatori.values.fold(0, (sum, cost) => sum + cost);
      tempList.add( Manager(nome: p.nome,
          numP: p.numP,
          numD: p.numD,
          numC: p.numC,
          numA: p.numA,
          giocatori: p.giocatori,
          budget: maxBudget - totalPlayerCost
      ));
    }
    return  League(nome: nome, maxBudget: maxBudget, partecipanti: tempList);
  }
}
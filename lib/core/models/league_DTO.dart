import '../../feature/league/domain/entities/leagues_entities.dart';
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
  
  League mapModeltoEntity(){
    List<LeagueManager> tempList = [];
    for(ManagerDTO p in partecipanti) {
      tempList.add(new LeagueManager(nome: p.nome, numP: p.numP, numD: p.numD, numC: p.numC, numA: p.numA, giocatori: p.giocatori));
    }
    return  League(nome: nome, maxBudget: maxBudget, partecipanti: tempList);
  }
}
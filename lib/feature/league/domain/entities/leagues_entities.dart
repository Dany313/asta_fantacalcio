
class League {
  final String nome;
  final int maxBudget;
  late final List<LeagueManager> partecipanti;

  League({
    required this.nome,
    required this.maxBudget,
    required this.partecipanti
  });
}

class LeagueManager {
  final String nome;
  final int numP;
  final int numD;
  final int numC;
  final int numA;
  final Map<String, int> giocatori;

  LeagueManager({
    required this.nome,
    required this.numP,
    required this.numD,
    required this.numC,
    required this.numA,
    required this.giocatori
  });
}
class Auction {
  final int maxBudget;
  final String leagueName;
  final int currentBet = 0;
  final String selectedManager = '';
  final String selectedPlayer = '';

  Auction({
    required this.maxBudget,
    required this.leagueName,
  });
}

class Player {
  final int id;
  final String nome;
  final String squadra;
  final String ruolo;
  final int quotAttuale;

  Player({
    required this.id,
    required this.nome,
    required this.squadra,
    required this.ruolo,
    required this.quotAttuale
  });
}
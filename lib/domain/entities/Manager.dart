class Manager {
  final String nome;
  final int numP;
  final int numD;
  final int numC;
  final int numA;
  final Map<String, int> giocatori;

  Manager({
    required this.nome,
    required this.numP,
    required this.numD,
    required this.numC,
    required this.numA,
    required this.giocatori
  });
}
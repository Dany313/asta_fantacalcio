class Manager {
  final String nome;
   int numP;
   int numD;
   int numC;
   int numA;
   int budget;
  final Map<String, int> giocatori;

  Manager({
    required this.nome,
    required this.numP,
    required this.numD,
    required this.numC,
    required this.numA,
    required this.budget,
    required this.giocatori
  });
}
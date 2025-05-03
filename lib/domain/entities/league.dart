import 'manager.dart';

class League {
  final String nome;
  final int maxBudget;
  late final List<Manager> partecipanti;

  League({
    required this.nome,
    required this.maxBudget,
    required this.partecipanti
  });
}
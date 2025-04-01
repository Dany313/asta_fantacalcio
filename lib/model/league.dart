import 'package:isar/isar.dart';
import 'club.dart';

part 'league.g.dart';

@Collection()
class League {
  // Campo identificatore (Isar gestirà l'auto incremento)
  Id id = Isar.autoIncrement;

  late String name;

  late int maxBudget;

  // Utilizza IsarLinks per definire la relazione con Club
  final clubs = IsarLinks<Club>();

  League({
    required this.name,
    required this.maxBudget,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! League) return false;
    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

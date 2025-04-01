import 'package:isar/isar.dart';
part 'player.g.dart';

@Collection()
class Player {
  // Campo identificatore: Isar gestirà l'auto incremento
  Id id = Isar.autoIncrement;

  final String name;

  final String role;

  final int acqValue;

  Player({
    required this.id,
    required this.name,
    required this.role,
    required this.acqValue
  });

}
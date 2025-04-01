import 'package:asta_fantacalcio/model/player.dart';
import 'package:isar/isar.dart';
part 'club.g.dart';

@Collection()
class Club {
  // Campo identificatore: Isar gestirà l'auto incremento
  Id id = Isar.autoIncrement;

  late String managerName;

  late int remainBudget;

  final players = IsarLinks<Player>();

  Club({
    required this.managerName,
    required this.remainBudget,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Club) return false;
    return other.managerName == managerName;
  }

  @override
  int get hashCode => managerName.hashCode;
}

import 'package:asta_fantacalcio/repositories/giocatori/giocatori_json_repository.dart';
import 'package:asta_fantacalcio/repositories/giocatori/giocatori_repository.dart';
import 'package:asta_fantacalcio/repositories/leghe/leghe_json_repository.dart';
import 'package:asta_fantacalcio/repositories/leghe/leghe_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  return [
    Provider(
      create:
          (context) => GiocatoriJsonRepository() as GiocatoriRepository,
    ),
    Provider(
      create:
          (context) => LegheJsonRepository() as LegheRepository,
    ),
  ];
}
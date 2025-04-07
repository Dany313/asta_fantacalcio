import '../../model/lega.dart';
import '../../utils/result.dart';

abstract class LegheRepository {

  Future<Result<List<Lega>>> getLegheList();

  Future<Result<void>> clearLegheList();

  Future<Result<Lega>> getLega(String nome);

  Future<Result<void>> addLega(String nomeLega, int maxBudget);

  Future<Result<void>> removeLega(String nomeLega);

  Future<Result<void>> addPartecipanteToLega(String nomeLega, String nomePartecipante);

  Future<Result<void>> removePartecipanteFromLega(String nomeLega, String nomePartecipante);

  Future<Result<void>> clearPartecipantiFromLega(String nomeLega);


}
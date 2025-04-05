import '../../model/lega.dart';
import '../../utils/result.dart';

abstract class LegheRepository {

  Future<Result<List<Lega>>> getLegheList();

  Future<Result<void>> clearLegheList();

  Future<Result<void>> addLega(String nomeLega, int maxBudget);

  Future<Result<void>> removeLega(Lega lega);

}
import '../../../../core/utils/result.dart';
import '../entities/leagues_entities.dart';

abstract class LegheRepository {
  Future<Result<List<League>>> getLegheList();
  Future<Result<void>> clearLegheList();
  Future<Result<League>> getLega(String nome);
  Future<Result<void>> addLega(String nomeLega, int maxBudget);
  Future<Result<void>> removeLega(String nomeLega);
}
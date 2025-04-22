import '../../core/utils/result.dart';
import '../entities/Manager.dart';

abstract class ManagersRepository {
  Future<Result<void>> addManagerToLeague(String nomeLega, String nomePartecipante);
  Future<Result<void>> removeManagerFromLeague(String nomeLega, String nomePartecipante);
  Future<Result<void>> clearManagersFromLeague(String nomeLega);
  Future<Result<List<Manager>>> getManagersFromLeague(String leagueName);
}
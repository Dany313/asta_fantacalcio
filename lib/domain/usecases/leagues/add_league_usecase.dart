
import '../../../core/utils/result.dart';
import '../../repositories/leghe_repository.dart';

class AddLeagueUseCase {
  AddLeagueUseCase({required LegheRepository legheRepository})
      : _legheRepository = legheRepository;

  final LegheRepository _legheRepository;

  Future<Result<void>> addLeague(String nomeLega, int maxBudget) async {
      print("Aggiungendo lega: $nomeLega con budget: $maxBudget");
      final result = await _legheRepository.addLega(nomeLega, maxBudget);
      return result;
  }
}
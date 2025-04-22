import '../../../../core/utils/result.dart';
import '../../../../domain/repositories/leghe_repository.dart';

class ClearLeagueUseCase {
  ClearLeagueUseCase({
    required LegheRepository legheRepository
  }): _legheRepository = legheRepository;

  final LegheRepository _legheRepository;

  Future<Result<void>> clear() async {
    print("Rimuovendo leghe");
    final result = await _legheRepository.clearLegheList();
    return result;
  }
}
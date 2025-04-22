import '../../../../core/utils/result.dart';
import '../../../../domain/repositories/leghe_repository.dart';

class RemoveLeagueUseCase {
  RemoveLeagueUseCase({
    required LegheRepository legheRepository
  }): _legheRepository = legheRepository;

  final LegheRepository _legheRepository;

  Future<Result<void>> removeLeague(String nomeLega) async {
    print("Rimuovendo lega: $nomeLega");
    final result = await _legheRepository.removeLega(nomeLega);
    return result;
  }
}
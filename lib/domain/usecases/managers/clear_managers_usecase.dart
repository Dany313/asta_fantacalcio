import '../../../core/utils/result.dart';
import '../../repositories/managers_repository.dart';

class ClearManagersUseCase {
  ClearManagersUseCase({required ManagersRepository managersRepository})
      : _managersRepository = managersRepository;

  final ManagersRepository _managersRepository;

  Future<Result<void>> clearManagers(String leagueName) async {
    print("Caricamento partecipanti...");
    final result = await _managersRepository.clearManagersFromLeague(leagueName);
    return result;
  }
}
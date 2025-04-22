import '../../../../core/utils/result.dart';
import '../entities/managers_entities.dart';
import '../repositories/managers_repository.dart';

class ManagersUseCase {
  ManagersUseCase({required ManagersRepository managersRepository})
      : _managersRepository = managersRepository;

  final ManagersRepository _managersRepository;

  Future<Result<List<Manager>>> getManagers(String leagueName) async {
    print("Caricamento partecipanti...");
    final result = await _managersRepository.getManagersFromLeague(leagueName);
    return result;
  }
}
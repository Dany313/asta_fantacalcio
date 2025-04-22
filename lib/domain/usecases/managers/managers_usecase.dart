import '../../../../core/utils/result.dart';
import '../../../../domain/repositories/managers_repository.dart';
import '../../entities/Manager.dart';

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
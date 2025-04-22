import '../../../../core/utils/result.dart';
import '../repositories/managers_repository.dart';

class RemoveManagerUseCase {
  RemoveManagerUseCase({required ManagersRepository managersRepository})
      : _managersRepository = managersRepository;

  final ManagersRepository _managersRepository;

  Future<Result<void>> removeManager(String nomeLega, String managerName) async {
    print("Rimuovo partecipante: $managerName alla lega: $nomeLega");
    final result = await _managersRepository.removeManagerFromLeague(nomeLega, managerName);
    return result;
  }
}
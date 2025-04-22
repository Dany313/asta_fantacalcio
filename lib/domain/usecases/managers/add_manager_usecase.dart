import '../../../core/utils/result.dart';
import '../../repositories/managers_repository.dart';

class AddManagerUseCase {
  AddManagerUseCase({required ManagersRepository managersRepository})
      : _managersRepository = managersRepository;

  final ManagersRepository _managersRepository;

  Future<Result<void>> addManager(String nomeLega, String managerName) async {
    print("Aggiungendo partecipante: $managerName alla lega: $nomeLega");
    final result = await _managersRepository.addManagerToLeague(nomeLega, managerName);
    return result;
  }
}
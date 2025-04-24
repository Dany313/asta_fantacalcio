import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../repositories/managers_repository.dart';

class AddManagerUseCase {

  Future<Either> call(String nomeLega, String managerName) async {
    print("Aggiungendo partecipante: $managerName alla lega: $nomeLega");
    return await serviceLocator<ManagersRepository>().addManagerToLeague(nomeLega, managerName);
  }
}
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../repositories/managers_repository.dart';

class RemoveManagerUseCase {

  Future<Either> call(String nomeLega, String managerName) async {
    print("Rimuovo partecipante: $managerName alla lega: $nomeLega");
    return await serviceLocator<ManagersRepository>().removeManagerFromLeague(nomeLega, managerName);

  }
}
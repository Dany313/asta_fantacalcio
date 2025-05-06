import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../repositories/managers_repository.dart';

class GetTeamsUseCase {
  Future<Either> call(String nomeLega, String managerName) async {
    return await serviceLocator<ManagersRepository>().getManagersFromLeague(nomeLega);
  }
}

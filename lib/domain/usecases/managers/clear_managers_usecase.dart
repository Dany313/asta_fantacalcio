import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../repositories/managers_repository.dart';

class ClearManagersUseCase {

  Future<Either> call(String leagueName) async {
    return await serviceLocator<ManagersRepository>().clearManagersFromLeague(leagueName);
  }
}
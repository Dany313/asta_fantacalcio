import 'package:dartz/dartz.dart';
import '../../../../domain/repositories/managers_repository.dart';
import '../../../service_locator.dart';

class ManagersUseCase {

  Future<Either> call(String leagueName) async {
    return await serviceLocator<ManagersRepository>().getManagersFromLeague(leagueName);
  }
}
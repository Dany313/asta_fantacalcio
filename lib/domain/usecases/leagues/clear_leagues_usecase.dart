import 'package:dartz/dartz.dart';
import '../../../../domain/repositories/leghe_repository.dart';
import '../../../service_locator.dart';

class ClearLeagueUseCase {

  Future<Either> call() async {
    return await serviceLocator<LegheRepository>().clearLegheList();
  }
}
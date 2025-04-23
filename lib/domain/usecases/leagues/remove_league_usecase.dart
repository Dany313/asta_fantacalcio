import 'package:dartz/dartz.dart';

import '../../../../domain/repositories/leghe_repository.dart';
import '../../../service_locator.dart';

class RemoveLeagueUseCase {

  Future<Either> call(String nomeLega) async {
    return await serviceLocator<LegheRepository>().removeLega(nomeLega);
  }
}
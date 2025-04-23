
import 'package:asta_fantacalcio/service_locator.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/leghe_repository.dart';

class AddLeagueUseCase {

  Future<Either> call(String nomeLega, int maxBudget) async {
    return await serviceLocator<LegheRepository>().addLega(nomeLega, maxBudget);
  }
}
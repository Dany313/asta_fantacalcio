import 'package:asta_fantacalcio/domain/repositories/leghe_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../service_locator.dart';

class LeaguesUseCase {

  Future<Either> call() async {
    return await serviceLocator<LegheRepository>().getLegheList();
  }
}

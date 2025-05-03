import 'package:asta_fantacalcio/domain/repositories/leghe_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/result.dart';
import '../../../service_locator.dart';
import '../../entities/auction.dart';
import '../../entities/league.dart';
import '../../entities/player.dart';
import '../../repositories/managers_repository.dart';
import '../../repositories/players_repository.dart';

class GetPlayersUseCase {

  Future<Either> call() async {
    return await serviceLocator<PlayersRepository>().getPLayers();

  }
}
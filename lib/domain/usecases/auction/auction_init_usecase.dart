import 'package:asta_fantacalcio/domain/repositories/leghe_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/result.dart';
import '../../../service_locator.dart';
import '../../entities/Auction.dart';
import '../../entities/League.dart';
import '../../entities/Player.dart';
import '../../repositories/managers_repository.dart';
import '../../repositories/players_repository.dart';

class AuctionInitUseCase {

  Future<Either> call(String leagueName) async {
    return await serviceLocator<ManagersRepository>().getManagersFromLeague(leagueName);
  }
}
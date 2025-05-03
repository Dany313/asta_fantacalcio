import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/result.dart';
import '../../../service_locator.dart';
import '../../entities/auction.dart';

class RemovePlayerUseCase {

  Future<Either> call(String leagueName, String managerName, String playerName) async {
    print("Rimuovendo giocatore: $playerName al manager $managerName");
    return await serviceLocator<AuctionRepository>()
        .removePlayerFromManager(leagueName, managerName, playerName);

  }
}
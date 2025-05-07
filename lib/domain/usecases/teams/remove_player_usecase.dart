import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';
import 'package:asta_fantacalcio/domain/repositories/players_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/result.dart';
import '../../../service_locator.dart';
import '../../entities/auction.dart';
import '../../entities/player.dart';

class RemovePlayerUseCase {

  Future<Either> call(String leagueName, String managerName, String playerName) async {
    print("Rimuovendo giocatore: $playerName al manager $managerName");
    String role = '';
    final result = await serviceLocator<PlayersRepository>().getPLayerRole(playerName);
    result.fold(
          (error) => print(error),
          (success) => role = success,
    );
    return await serviceLocator<AuctionRepository>()
        .removePlayerFromManager(leagueName, managerName, playerName, role);

  }

}
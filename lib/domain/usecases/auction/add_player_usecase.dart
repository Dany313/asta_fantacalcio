import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';
import 'package:asta_fantacalcio/domain/repositories/players_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

class AddPlayerUseCase {

  Future<Either> call(String leagueName, String managerName, String playerName, int price) async {
    print("Aggiungendo giocatore: $playerName al manager $managerName con prezzo: $price");
    String role = '';
    final result = await serviceLocator<PlayersRepository>().getPLayerRole(playerName);
    result.fold(
          (error) => print(error),
          (success) => role = success,
    );
    return await serviceLocator<AuctionRepository>()
        .addPlayerToManager(leagueName, managerName, playerName, role, price);

  }
}